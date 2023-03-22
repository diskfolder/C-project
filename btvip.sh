#！/斌/庆典
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~ / bin
导出路径
LANG=en_US.UTF-8

Btapi_Url= ' https://bt.cxinyun.com '
Check_Api= $( curl -Ss --connect-timeout 5 -m 2 $Btapi_Url /api/SetupCount )
如果[ “ $Check_Api ” ！=  '确定' ] ；然后
	Red_Error "宝塔云端无法连接，因此安装过程序已停止！" ;
菲

如果[ $( whoami )  !=  " root " ] ; 然后
	echo  "请使用root权限执行宝塔安装命令！"
	出口1 ;
菲

is64bit= $( getconf LONG_BIT )
如果[ " ${is64bit} "  !=  ' 64 ' ] ; 然后
	Red_Error "抱抱, 当前面板版本不支持32位系统, 请使用64位系统或安装宝塔5.9! " ;
菲

Centos6Check= $( cat /etc/redhat-release | grep ' 6. '  | grep -iE ' centos|Red Hat ' )
如果[ " ${Centos6Check} " ] ; 然后
	echo  " Centos6不支持安装宝塔面板，请更换Centos7/8安装宝塔面板"
	出口1
菲 

UbuntuCheck= $( cat /etc/issue | grep Ubuntu | awk ' {print $2} ' | cut -f 1 -d ' . ' )
if [ " ${UbuntuCheck} " ] && [ " ${UbuntuCheck} "  -lt  " 16 " ] ; 然后
	echo  " Ubuntu ${UbuntuCheck}不支持安装宝塔面板，建议更换Ubuntu18/20安装宝塔面板"
	出口1
菲

清除
#输出一条提示信息让用户确认是否安装
echo -e " \033[31m 欢迎使用宝塔Linux企业版一键安装脚本 \033[0m "
echo -e " \033[32m 创信博客: blog.cxinyun.cn \033[0m "
# echo -e "\033[31m 此脚本自2022年9月1日起暂停新用户安装\033[0m"
# echo -e "\033[31m 未授权安装可能会导致面板功能无法使用 \033[0m"
睡2秒
echo -e " \033[31m 3秒后安装将继续 \033[0m "
睡眠 1s
echo -e " \033[31m 2秒后安装将继续 \033[0m "
睡眠 1s
echo -e " \033[31m 1秒后安装将继续 \033[0m "
睡眠 1s

CD  ~
设置路径= “ /www ”
python_bin= $setup_path /server/panel/pyenv/bin/python
cpu_cpunt= $( cat /proc/cpuinfo | grep 处理器| wc -l )

如果[ “ $1 ” ] ；然后
	IDC_CODE= $1
菲

GetSysInfo (){
	如果[ -s  " /etc/redhat-release " ] ; 然后
		SYS_VERSION= $(猫 /etc/redhat-release )
	elif [ -s  " /etc/issue " ] ;  然后
		SYS_VERSION= $(猫 /etc/问题)
	菲
	SYS_INFO= $( uname -a )
	SYS_BIT= $( getconf LONG_BIT )
	MEM_TOTAL= $( free -m | grep Mem | awk ' {print $2} ' )
	CPU_INFO= $( getconf _NPROCESSORS_ONLN )

	回声-e ${SYS_VERSION}
	echo -e 位：${SYS_BIT}内存：${MEM_TOTAL} M 核心：${CPU_INFO}
	echo -e ${SYS_INFO}

	如果[ -z  " ${os_version} " ] ; 然后
		echo -e " ============================================== "
		echo -e "检测到为非常用系统安装,建议更换至Centos-7或Debian-10+或Ubuntu-20+系统安装宝塔面板"
		echo -e "详情请查看系统兼容表：https://docs.qq.com/sheet/DUm54VUtyTVNlc21H?tab=BB08J2 "
		echo -e "特殊情况可通以下联系方式寻求安装协助情况"
	菲

	is64bit= $( getconf LONG_BIT )
	如果[ " ${is64bit} "  ==  ' 32 ' ] ; 然后
		echo -e "宝塔面板不支持32位系统进入安装，请使用64位系统/服务器架构进入安装宝塔"
		出口1
	菲

	S390X_CHECK= $( uname -a | grep s390x )
	如果[ “ ${S390X_CHECK} ” ] ；然后
		echo -e "宝塔面板不支持s390x架构进入安装，请使用64位系统/服务器架构进入安装宝塔"
		出口1
	菲

	echo -e " ============================================== "
	echo -e "请截图以上报错信息发布至论坛www.bt.cn/bbs求助"
}
红色错误（）{
	echo  ' ================================================ = ' ;
	printf  ' \033[1;31;40m%b\033[0m\n '  " $@ " ;
	获取系统信息
	出口1 ;
}
Lock_Clear (){
	如果[ -f  " /etc/bt_crack.pl " ] ; 然后
		chattr -R -ia /www
		chattr -ia /etc/init.d/bt
		\c p -rpa /www/backup/panel/vhost/ * /www/server/panel/vhost/
		mv /www/server/panel/BTPanel/__init__.bak /www/server/panel/BTPanel/__init__.py
		rm -f /etc/bt_crack.pl
	菲
}
安装_检查（）{
	如果[ " ${INSTALL_FORCE} " ] ; 然后
		返回
	菲
	echo -e " ------------------------------------------ ------ ”
	echo -e "检查已经有其他Web/mysql环境，安装宝塔可能影响现在有站点及数据"
	echo -e " Web/mysql 服务已安装，无法安装面板"
	echo -e " ------------------------------------------ ------ ”
	echo -e "已知风险/输入yes强制安装"
	read -p "输入 yes 强制安装: " yes ;
	如果[ “ $是” ！=  “是” ] ；然后
		回声-e “ ------------ ”
		echo  "取消安装"
		退出；
	菲
	安装力= “真”
}
系统检查（）{
	MYSQLD_CHECK= $( ps -ef | grep mysqld | grep -v grep | grep -v /www/server/mysql )
	PHP_CHECK= $( ps -ef | grep php-fpm | grep master | grep -v /www/server/php )
	NGINX_CHECK= $( ps -ef | grep nginx | grep master | grep -v /www/server/nginx )
	HTTPD_CHECK= $( ps -ef | grep -E ' httpd|apache ' | grep -v /www/server/apache | grep -v grep )
	如果[ " ${PHP_CHECK} " ] || [ “ ${MYSQLD_CHECK} ” ] || [ “ ${NGINX_CHECK} ” ] || [ " ${HTTPD_CHECK} " ] ; 然后
		安装检查
	菲
}
设置_SSL (){
    回声-e “ ”
    echo -e " ------------------------------------------ -------------------------- ”
    echo -e "为了您的面板使用安全，建议您开启面板SSL，开启后请使用https访问宝塔面板"
    echo -e "输入y回车即打开面板SSL并进行下一步安装"
    echo -e "输入n回车跳过面板SSL配置，直接进入安装"
    echo -e " 10秒后将跳过SSL配置，直接进入面板安装"
    echo -e " ------------------------------------------ -------------------------- ”
    回声-e “ ”
    read -t 10 -p "是否确定打开面板 SSL ? (y/n): " yes

    如果[ $?  != 0 ] ; 然后
        SET_SSL=假
    别的
        案例 “ $yes ” 在
            y）
                SET_SSL=真
                ;;
            名词）
                SET_SSL=假
				rm -f /www/server/panel/data/ssl.pl
                ;;
            * )
                设置_SSL
        esac
    菲
}
Get_Pack_Manager (){
	如果[ -f  " /usr/bin/yum " ] && [ -d  " /etc/yum.repos.d " ] ;  然后
		下午= “百胜”
	elif [ -f  " /usr/bin/apt-get " ] && [ -f  " /usr/bin/dpkg " ] ;  然后
		下午= “容易得到”		
	菲
}
自动交换()
{
	swap= $( free | grep Swap | awk ' {print $2} ' )
	如果[ " ${swap} "  -gt 1 ] ; 然后
		echo  " Swap 总大小: $swap " ;
		返回；
	菲
	如果[ ！ -d /www ] ; 然后
		目录 /www
	菲
	交换文件= “ /www/交换”
	dd if=/dev/zero of= $swapFile bs=1M count=1025
	mkswap -f $交换文件
	swapon $swapFile
	echo  " $swapFile     swap swap defaults 0 0 "  >> /etc/fstab
	交换= `免费| grep 交换| awk ' {print $2} ' `
	如果[ $swap  -gt 1 ] ; 然后
		echo  " Swap 总大小: $swap " ;
		返回；
	菲
	
	sed -i " /\/www\/swap/d " /etc/fstab
	rm -f $交换文件
}
服务_添加(){
	如果[ " ${PM} "  ==  " yum " ] || [ " ${PM} "  ==  " dnf " ] ;  然后
		检查配置 -- 添加 bt
		chkconfig --level 2345 bt on
		Centos9Check= $( cat /etc/redhat-release | grep ' 9 ' )
		如果[ " ${Centos9Check} " ] ; 然后
            wget -O /usr/lib/systemd/system/btpanel.service ${download_Url} /init/systemd/btpanel.service
			systemctl启用btpanel
		菲		
	elif [ " ${PM} "  ==  " apt-get " ] ;  然后
		更新 rc.d bt 默认值
	菲 
}
Set_Centos_Repo (){
	HUAWEI_CHECK= $( cat /etc/motd | grep "华为云" )
	if [ " ${HUAWEI_CHECK} " ] && [ " ${is64bit} "  ==  " 64 " ] ; 然后
		\c p -rpa /etc/yum.repos.d/ /etc/yumBak
		sed -i ' s/mirrorlist/#mirrorlist/g ' /etc/yum.repos.d/CentOS- * .repo
		sed -i ' s|#baseurl=http://mirror.centos.org|baseurl=http://vault.epel.cloud|g ' /etc/yum.repos.d/CentOS- * .repo
		rm -f /etc/yum.repos.d/epel.repo
		rm -f /etc/yum.repos.d/epel- *
	菲
	ALIYUN_CHECK= $( cat /etc/motd | grep "阿里云" )
	如果[   " ${ALIYUN_CHECK} " ] && [ " ${is64bit} "  ==  " 64 " ] && [ !  -f  " /etc/yum.repos.d/Centos-vault-8.5.2111.repo " ] ; 然后
		重命名' .repo '  ' .repo.bak ' /etc/yum.repos.d/ * .repo
		wget https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo -O /etc/yum.repos.d/Centos-vault-8.5.2111.repo
		wget https://mirrors.aliyun.com/repo/epel-archive-8.repo -O /etc/yum.repos.d/epel-archive-8.repo
		sed -i ' s/mirrors.cloud.aliyuncs.com/url_tmp/g '   /etc/yum.repos.d/Centos-vault-8.5.2111.repo &&   sed -i ' s/mirrors.aliyun.com/mirrors .cloud.aliyuncs.com/g ' /etc/yum.repos.d/Centos-vault-8.5.2111.repo && sed -i ' s/url_tmp/mirrors.aliyun.com/g ' /etc/yum.repos .d/Centos-vault-8.5.2111.repo
		sed -i ' s/mirrors.aliyun.com/mirrors.cloud.aliyuncs.com/g ' /etc/yum.repos.d/epel-archive-8.repo
	菲
	MIRROR_CHECK= $( cat /etc/yum.repos.d/CentOS-Linux-AppStream.repo | grep " [^#]mirror.centos.org " )
	if [ " ${MIRROR_CHECK} " ] && [ " ${is64bit} "  ==  " 64 " ] ; 然后
		\c p -rpa /etc/yum.repos.d/ /etc/yumBak
		sed -i ' s/mirrorlist/#mirrorlist/g ' /etc/yum.repos.d/CentOS- * .repo
		sed -i ' s|#baseurl=http://mirror.centos.org|baseurl=http://vault.epel.cloud|g ' /etc/yum.repos.d/CentOS- * .repo
	菲
}
get_node_url (){
	如果[ ！ -f /bin/curl ] ; 然后
		如果[ " ${PM} "  =  " yum " ] ;  然后
			yum 安装 curl -y
		elif [ " ${PM} "  =  " apt-get " ] ;  然后
			apt-get 安装 curl -y
		菲
	菲

	如果[ -f  “ /www/node.pl ” ] ；然后
		下载地址= $( cat /www/node.pl )
		echo  "下载节点: $download_Url " ;
		echo  ' ------------------------------------------ ' ;
		返回
	菲
	
	echo  ' ------------------------------------------ ' ;
	echo  "选择下载节点... " ;
	nodes=(https://dg2.bt.cn https://dg1.bt.cn https://download.bt.cn) ;

	如果[ “ $1 ” ] ；然后
		节点=( $( echo ${nodes[*]} | sed " s# ${1} ## " ) )
	菲

	tmp_file1=/dev/shm/net_test1.pl
	tmp_file2=/dev/shm/net_test2.pl
	[ -f  " ${tmp_file1} " ] && rm -f ${tmp_file1}
	[ -f  " ${tmp_file2} " ] && rm -f ${tmp_file2}
	触摸$tmp_file1
	触摸$tmp_file2
	对于 ${nodes[@]}中的节点 ； 
	做
		NODE_CHECK= $( curl --connect-timeout 3 -m 3 2> /dev/null -w " %{http_code} %{time_total} "  ${node} /net_test | xargs )
		RES= $( echo ${NODE_CHECK} | awk ' {print $1} ' )
		NODE_STATUS= $( echo ${NODE_CHECK} | awk ' {print $2} ' )
		TIME_TOTAL= $( echo ${NODE_CHECK} | awk ' {print $3 * 1000 - 500 } ' | cut -d ' . ' -f 1 )
		如果[ " ${NODE_STATUS} "  ==  " 200 " ] ; 然后
			如果[ $TIME_TOTAL  -lt 100 ] ; 然后
				如果[ $RES  -ge 1500 ] ; 然后
					echo  " $RES  $node "  >>  $tmp_file1
				菲
			别的
				如果[ $RES  -ge 1500 ] ; 然后
					echo  " $TIME_TOTAL  $node "  >>  $tmp_file2
				菲
			菲

			我= $(( $i + 1 ))
			如果[ $TIME_TOTAL  -lt 100 ] ; 然后
				如果[ $RES  -ge 3000 ] ; 然后
					打破;
				菲
			菲	
		菲
	完毕

	NODE_URL= $( cat $tmp_file1 | sort -r -g -t "  " -k 1 | head -n 1 | awk ' {print $2} ' )
	如果[ -z  " $NODE_URL " ] ; 然后
		NODE_URL= $( cat $tmp_file2 | sort -g -t "  " -k 1 | head -n 1 | awk ' {print $2} ' )
		如果[ -z  " $NODE_URL " ] ; 然后
			NODE_URL= ' https://download.bt.cn ' ;
		菲
	菲
	rm -f $tmp_file1
	rm -f $tmp_file2
	下载_Url= $NODE_URL
	echo  "下载节点: $download_Url " ;
	echo  ' ------------------------------------------ ' ;
}
Remove_Package (){
	本地PackageNmae= $1
	如果[ " ${PM} "  ==  " yum " ] ; 然后
		isPackage= $( rpm -q ${PackageNmae} | grep “未安装” )
		如果[ -z  " ${isPackage} " ] ; 然后
			yum 删除${PackageNmae} -y
		菲 
	elif [ " ${PM} "  ==  " apt-get " ] ; 然后
		isPackage= $( dpkg -l | grep ${PackageNmae} )
		如果[ " ${PackageNmae} " ] ; 然后
			apt-get remove ${PackageNmae} -y
		菲
	菲
}
Install_RPM_Pack (){
	yumPath=/etc/yum.conf
	Centos8Check= $( cat /etc/redhat-release | grep ' 8. '  | grep -iE ' centos|Red Hat ' )
	if [ "${Centos8Check}" ];then
		Set_Centos_Repo
	fi	
	isExc=$(cat $yumPath|grep httpd)
	if [ "$isExc" = "" ];then
		echo "exclude=httpd nginx php mysql mairadb python-psutil python2-psutil" >> $yumPath
	fi

	#SYS_TYPE=$(uname -a|grep x86_64)
	#yumBaseUrl=$(cat /etc/yum.repos.d/CentOS-Base.repo|grep baseurl=http|cut -d '=' -f 2|cut -d '$' -f 1|head -n 1)
	#[ "${yumBaseUrl}" ] && checkYumRepo=$(curl --connect-timeout 5 --head -s -o /dev/null -w %{http_code} ${yumBaseUrl})	
	#if [ "${checkYumRepo}" != "200" ] && [ "${SYS_TYPE}" ];then
	#	curl -Ss --connect-timeout 3 -m 60 http://download.bt.cn/install/yumRepo_select.sh|bash
	#fi
	
	#尝试同步时间(从bt.cn)
	echo 'Synchronizing system time...'
	getBtTime=$(curl -sS --connect-timeout 3 -m 60 http://www.bt.cn/api/index/get_time)
	if [ "${getBtTime}" ];then	
		date -s "$(date -d @$getBtTime +"%Y-%m-%d %H:%M:%S")"
	fi

	if [ -z "${Centos8Check}" ]; then
		yum install ntp -y
		rm -rf /etc/localtime
		ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

		#尝试同步国际时间(从ntp服务器)
		ntpdate 0.asia.pool.ntp.org
		setenforce 0
	fi

	startTime=`date +%s`

	sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
	#yum remove -y python-requests python3-requests python-greenlet python3-greenlet
	yumPacks="libcurl-devel wget tar gcc make zip unzip openssl openssl-devel gcc libxml2 libxml2-devel libxslt* zlib zlib-devel libjpeg-devel libpng-devel libwebp libwebp-devel freetype freetype-devel lsof pcre pcre-devel vixie-cron crontabs icu libicu-devel c-ares libffi-devel bzip2-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel qrencode"
	yum install -y ${yumPacks}

	for yumPack in ${yumPacks}
	do
		rpmPack=$(rpm -q ${yumPack})
		packCheck=$(echo ${rpmPack}|grep not)
		if [ "${packCheck}" ]; then
			yum install ${yumPack} -y
		fi
	done
	if [ -f "/usr/bin/dnf" ]; then
		dnf install -y redhat-rpm-config
	fi

	ALI_OS=$(cat /etc/redhat-release |grep "Alibaba Cloud Linux release 3")
	if [ -z "${ALI_OS}" ];then 
		yum install epel-release -y
	fi
}
Install_Deb_Pack(){
	ln -sf bash /bin/sh
	UBUNTU_22=$(cat /etc/issue|grep "Ubuntu 22")
	if [ "${UBUNTU_22}" ];then
		apt-get remove needrestart -y
	fi
	ALIYUN_CHECK=$(cat /etc/motd|grep "Alibaba Cloud ")
	if [ "${ALIYUN_CHECK}" ] && [ "${UBUNTU_22}" ];then
		apt-get remove libicu70 -y
	fi
	apt-get update -y
	apt-get install bash -y
	if [ -f "/usr/bin/bash" ];then
		ln -sf /usr/bin/bash /bin/sh
	fi
	apt-get install ruby -y
	apt-get install lsb-release -y
	#apt-get install ntp ntpdate -y
	#/etc/init.d/ntp stop
	#update-rc.d ntp remove
	#cat >>~/.profile<<EOF
	#TZ='Asia/Shanghai'; export TZ
	#EOF
	#rm -rf /etc/localtime
	#cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	#echo 'Synchronizing system time...'
	#ntpdate 0.asia.pool.ntp.org
	#apt-get upgrade -y
	LIBCURL_VER=$(dpkg -l|grep libcurl4|awk '{print $3}')
	if [ "${LIBCURL_VER}" == "7.68.0-1ubuntu2.8" ];then
		apt-get remove libcurl4 -y
		apt-get install curl -y
	fi

	debPacks="wget curl libcurl4-openssl-dev gcc make zip unzip tar openssl libssl-dev gcc libxml2 libxml2-dev zlib1g zlib1g-dev libjpeg-dev libpng-dev lsof libpcre3 libpcre3-dev cron net-tools swig build-essential libffi-dev libbz2-dev libncurses-dev libsqlite3-dev libreadline-dev tk-dev libgdbm-dev libdb-dev libdb++-dev libpcap-dev xz-utils git qrencode";
	apt-get install -y $debPacks --force-yes

	for debPack in ${debPacks}
	do
		packCheck=$(dpkg -l|grep ${debPack})
		if [ "$?" -ne "0" ] ;then
			apt-get install -y $debPack
		fi
	done

	if [ ! -d '/etc/letsencrypt' ];then
		mkdir -p /etc/letsencryp
		mkdir -p /var/spool/cron
		if [ ! -f '/var/spool/cron/crontabs/root' ];then
			echo '' > /var/spool/cron/crontabs/root
			chmod 600 /var/spool/cron/crontabs/root
		fi	
	fi
}
Get_Versions(){
	redhat_version_file="/etc/redhat-release"
	deb_version_file="/etc/issue"
	if [ -f $redhat_version_file ];then
		os_type='el'
		is_aliyunos=$(cat $redhat_version_file|grep Aliyun)
		if [ "$is_aliyunos" != "" ];then
			return
		fi
		os_version=$(cat $redhat_version_file|grep CentOS|grep -Eo '([0-9]+\.)+[0-9]+'|grep -Eo '^[0-9]')
		if [ "${os_version}" = "5" ];then
			os_version=""
		fi
		if [ -z "${os_version}" ];then
			os_version=$(cat /etc/redhat-release |grep Stream|grep -oE 8)
		fi
	else
		os_type='ubuntu'
		os_version=$(cat $deb_version_file|grep Ubuntu|grep -Eo '([0-9]+\.)+[0-9]+'|grep -Eo '^[0-9]+')
		if [ "${os_version}" = "" ];then
			os_type='debian'
			os_version=$(cat $deb_version_file|grep Debian|grep -Eo '([0-9]+\.)+[0-9]+'|grep -Eo '[0-9]+')
			if [ "${os_version}" = "" ];then
				os_version=$(cat $deb_version_file|grep Debian|grep -Eo '[0-9]+')
			fi
			if [ "${os_version}" = "8" ];then
				os_version=""
			fi
			if [ "${is64bit}" = '32' ];then
				os_version=""
			fi
		else
			if [ "$os_version" = "14" ];then
				os_version=""
			fi
			if [ "$os_version" = "12" ];then
				os_version=""
			fi
			if [ "$os_version" = "19" ];then
				os_version=""
			fi
			if [ "$os_version" = "21" ];then
				os_version=""
			fi
			if [ "$os_version" = "20" ];then
				os_version2004=$(cat /etc/issue|grep 20.04)
				if [ -z "${os_version2004}" ];then
					os_version=""
				fi
			fi
		fi
	fi
}
Install_Python_Lib(){
	curl -Ss --connect-timeout 3 -m 60 $download_Url/install/pip_select.sh|bash
	pyenv_path="/www/server/panel"
	if [ -f $pyenv_path/pyenv/bin/python ];then
	 	is_ssl=$($python_bin -c "import ssl" 2>&1|grep cannot)
		$pyenv_path/pyenv/bin/python3.7 -V
		if [ $? -eq 0 ] && [ -z "${is_ssl}" ];then
			chmod -R 700 $pyenv_path/pyenv/bin
			is_package=$($python_bin -m psutil 2>&1|grep package)
			if [ "$is_package" = "" ];then
				wget -O $pyenv_path/pyenv/pip.txt $download_Url/install/pyenv/pip.txt -T 5
				$pyenv_path/pyenv/bin/pip install -U pip
				$pyenv_path/pyenv/bin/pip install -U setuptools==65.5.0
				$pyenv_path/pyenv/bin/pip install -r $pyenv_path/pyenv/pip.txt
			fi
			source $pyenv_path/pyenv/bin/activate
			chmod -R 700 $pyenv_path/pyenv/bin
			return
		else
			rm -rf $pyenv_path/pyenv
		fi
	fi

	is_loongarch64=$(uname -a|grep loongarch64)
	if [ "$is_loongarch64" != "" ] && [ -f "/usr/bin/yum" ];then
		yumPacks="python3-devel python3-pip python3-psutil python3-gevent python3-pyOpenSSL python3-paramiko python3-flask python3-rsa python3-requests python3-six python3-websocket-client"
		yum install -y ${yumPacks}
		for yumPack in ${yumPacks}
		do
			rpmPack=$(rpm -q ${yumPack})
			packCheck=$(echo ${rpmPack}|grep not)
			if [ "${packCheck}" ]; then
				yum install ${yumPack} -y
			fi
		done

		pip3 install -U pip
		pip3 install Pillow psutil pyinotify pycryptodome upyun oss2 pymysql qrcode qiniu redis pymongo Cython configparser cos-python-sdk-v5 supervisor gevent-websocket pyopenssl
		pip3 install flask==1.1.4
		pip3 install Pillow -U

		pyenv_bin=/www/server/panel/pyenv/bin
		mkdir -p $pyenv_bin
		ln -sf /usr/local/bin/pip3 $pyenv_bin/pip
		ln -sf /usr/local/bin/pip3 $pyenv_bin/pip3
		ln -sf /usr/local/bin/pip3 $pyenv_bin/pip3.7

		if [ -f "/usr/bin/python3.7" ];then
			ln -sf /usr/bin/python3.7 $pyenv_bin/python
			ln -sf /usr/bin/python3.7 $pyenv_bin/python3
			ln -sf /usr/bin/python3.7 $pyenv_bin/python3.7
		elif [ -f "/usr/bin/python3.6"  ]; then
			ln -sf /usr/bin/python3.6 $pyenv_bin/python
			ln -sf /usr/bin/python3.6 $pyenv_bin/python3
			ln -sf /usr/bin/python3.6 $pyenv_bin/python3.7
		fi

		echo > $pyenv_bin/activate

		return
	fi

	py_version="3.7.8"
	mkdir -p $pyenv_path
	echo "True" > /www/disk.pl
	if [ ! -w /www/disk.pl ];then
		Red_Error "ERROR: Install python env fielded." "ERROR: /www目录无法写入，请检查目录/用户/磁盘权限！"
	fi
	os_type='el'
	os_version='7'
	is_export_openssl=0
	Get_Versions

	echo "OS: $os_type - $os_version"
	is_aarch64=$(uname -a|grep aarch64)
	if [ "$is_aarch64" != "" ];then
		is64bit="aarch64"
	fi
	
	if [ -f "/www/server/panel/pymake.pl" ];then
		os_version=""
		rm -f /www/server/panel/pymake.pl
	fi	

	if [ "${os_version}" != "" ];then
		pyenv_file="/www/pyenv.tar.gz"
		wget -O $pyenv_file $download_Url/install/pyenv/pyenv-${os_type}${os_version}-x${is64bit}.tar.gz -T 10
		if [ "$?" != "0" ];then
			get_node_url $download_Url
			wget -O $pyenv_file $download_Url/install/pyenv/pyenv-${os_type}${os_version}-x${is64bit}.tar.gz -T 10
		fi
		tmp_size=$(du -b $pyenv_file|awk '{print $1}')
		if [ $tmp_size -lt 703460 ];then
			rm -f $pyenv_file
			echo "ERROR: Download python env fielded."
		else
			echo "Install python env..."
			tar zxvf $pyenv_file -C $pyenv_path/ > /dev/null
			chmod -R 700 $pyenv_path/pyenv/bin
			if [ ! -f $pyenv_path/pyenv/bin/python ];then
				rm -f $pyenv_file
				Red_Error "ERROR: Install python env fielded." "ERROR: 下载宝塔运行环境失败，请尝试重新安装！" 
			fi
			$pyenv_path/pyenv/bin/python3.7 -V
			if [ $? -eq 0 ];then
				rm -f $pyenv_file
				ln -sf $pyenv_path/pyenv/bin/pip3.7 /usr/bin/btpip
				ln -sf $pyenv_path/pyenv/bin/python3.7 /usr/bin/btpython
				source $pyenv_path/pyenv/bin/activate
				return
			else
				rm -f $pyenv_file
				rm -rf $pyenv_path/pyenv
			fi
		fi
	fi

	cd /www
	python_src='/www/python_src.tar.xz'
	python_src_path="/www/Python-${py_version}"
	wget -O $python_src $download_Url/src/Python-${py_version}.tar.xz -T 5
	tmp_size=$(du -b $python_src|awk '{print $1}')
	if [ $tmp_size -lt 10703460 ];then
		rm -f $python_src
		Red_Error "ERROR: Download python source code fielded." "ERROR: 下载宝塔运行环境失败，请尝试重新安装！"
	fi
	tar xvf $python_src
	rm -f $python_src
	cd $python_src_path
	./configure --prefix=$pyenv_path/pyenv
	make -j$cpu_cpunt
	make install
	if [ ! -f $pyenv_path/pyenv/bin/python3.7 ];then
		rm -rf $python_src_path
		Red_Error "ERROR: Make python env fielded." "ERROR: 编译宝塔运行环境失败！"
	fi
	cd ~
	rm -rf $python_src_path
	wget -O $pyenv_path/pyenv/bin/activate $download_Url/install/pyenv/activate.panel -T 5
	wget -O $pyenv_path/pyenv/pip.txt $download_Url/install/pyenv/pip-3.7.8.txt -T 5
	ln -sf $pyenv_path/pyenv/bin/pip3.7 $pyenv_path/pyenv/bin/pip
	ln -sf $pyenv_path/pyenv/bin/python3.7 $pyenv_path/pyenv/bin/python
	ln -sf $pyenv_path/pyenv/bin/pip3.7 /usr/bin/btpip
	ln -sf $pyenv_path/pyenv/bin/python3.7 /usr/bin/btpython
	chmod -R 700 $pyenv_path/pyenv/bin
	$pyenv_path/pyenv/bin/pip install -U pip
	$pyenv_path/pyenv/bin/pip install -U setuptools==65.5.0
	$pyenv_path/pyenv/bin/pip install -U wheel==0.34.2 
	$pyenv_path/pyenv/bin/pip install -r $pyenv_path/pyenv/pip.txt
	source $pyenv_path/pyenv/bin/activate

	is_gevent=$($python_bin -m gevent 2>&1|grep -oE package)
	is_psutil=$($python_bin -m psutil 2>&1|grep -oE package)
	if [ "${is_gevent}" != "${is_psutil}" ];then
		Red_Error "ERROR: psutil/gevent install failed!"
	fi
}
Install_Bt(){
	panelPort="8888"
	if [ -f ${setup_path}/server/panel/data/port.pl ];then
		panelPort=$(cat ${setup_path}/server/panel/data/port.pl)
	else
		panelPort=$(expr $RANDOM % 55535 + 10000)
	fi
	mkdir -p ${setup_path}/server/panel/logs
	mkdir -p ${setup_path}/server/panel/vhost/apache
	mkdir -p ${setup_path}/server/panel/vhost/nginx
	mkdir -p ${setup_path}/server/panel/vhost/rewrite
	mkdir -p ${setup_path}/server/panel/install
	mkdir -p /www/server
	mkdir -p /www/wwwroot
	mkdir -p /www/wwwlogs
	mkdir -p /www/backup/database
	mkdir -p /www/backup/site

	if [ ! -d "/etc/init.d" ];then
		mkdir -p /etc/init.d
	fi

	if [ -f "/etc/init.d/bt" ]; then
		/etc/init.d/bt stop
		sleep 1
	fi

	wget -O /etc/init.d/bt ${download_Url}/install/src/bt6.init -T 10
	wget -O /www/server/panel/install/public.sh ${Btapi_Url}/install/public.sh -T 10
	wget -O panel.zip ${Btapi_Url}/install/src/panel6.zip -T 10

	if [ -f "${setup_path}/server/panel/data/default.db" ];then
		if [ -d "/${setup_path}/server/panel/old_data" ];then
			rm -rf ${setup_path}/server/panel/old_data
		fi
		mkdir -p ${setup_path}/server/panel/old_data
		d_format=$(date +"%Y%m%d_%H%M%S")
		\cp -arf ${setup_path}/server/panel/data/default.db ${setup_path}/server/panel/data/default_backup_${d_format}.db
		mv -f ${setup_path}/server/panel/data/default.db ${setup_path}/server/panel/old_data/default.db
		mv -f ${setup_path}/server/panel/data/system.db ${setup_path}/server/panel/old_data/system.db
		mv -f ${setup_path}/server/panel/data/port.pl ${setup_path}/server/panel/old_data/port.pl
		mv -f ${setup_path}/server/panel/data/admin_path.pl ${setup_path}/server/panel/old_data/admin_path.pl
	fi

	if [ ! -f "/usr/bin/unzip" ]; then
		if [ "${PM}" = "yum" ]; then
			yum install unzip -y
		elif [ "${PM}" = "apt-get" ]; then
			apt-get update
			apt-get install unzip -y
		fi
	fi

	unzip -o panel.zip -d ${setup_path}/server/ > /dev/null

	if [ -d "${setup_path}/server/panel/old_data" ];then
		mv -f ${setup_path}/server/panel/old_data/default.db ${setup_path}/server/panel/data/default.db
		mv -f ${setup_path}/server/panel/old_data/system.db ${setup_path}/server/panel/data/system.db
		mv -f ${setup_path}/server/panel/old_data/port.pl ${setup_path}/server/panel/data/port.pl
		mv -f ${setup_path}/server/panel/old_data/admin_path.pl ${setup_path}/server/panel/data/admin_path.pl
		if [ -d "/${setup_path}/server/panel/old_data" ];then
			rm -rf ${setup_path}/server/panel/old_data
		fi
	fi

	if [ ! -f ${setup_path}/server/panel/tools.py ] || [ ! -f ${setup_path}/server/panel/BT-Panel ];then
		ls -lh panel.zip
		Red_Error "ERROR: Failed to download, please try install again!" "ERROR: 下载宝塔失败，请尝试重新安装！"
	fi

	rm -f panel.zip
	rm -f ${setup_path}/server/panel/class/*.pyc
	rm -f ${setup_path}/server/panel/*.pyc

	chmod +x /etc/init.d/bt
	chmod -R 600 ${setup_path}/server/panel
	chmod -R +x ${setup_path}/server/panel/script
	ln -sf /etc/init.d/bt /usr/bin/bt
	echo "${panelPort}" > ${setup_path}/server/panel/data/port.pl
	wget -O /etc/init.d/bt ${download_Url}/install/src/bt7.init -T 10
	wget -O /www/server/panel/init.sh ${download_Url}/install/src/bt7.init -T 10
	wget -O /www/server/panel/data/softList.conf ${download_Url}/install/conf/softList.conf

	rm -f /www/server/panel/class/*.so
	if [ ! -f /www/server/panel/data/not_workorder.pl ]; then
		echo "True" > /www/server/panel/data/not_workorder.pl
	fi
	if [ ! -f /www/server/panel/data/userInfo.json ]; then
		echo "{\"uid\":1,\"username\":\"Administrator\",\"address\":\"127.0.0.1\",\"serverid\":\"1\",\"access_key\":\"test\",\"secret_key\":\"123456\",\"ukey\":\"123456\",\"state\":1}" > /www/server/panel/data/userInfo.json
	fi
}
Set_Bt_Panel(){
	Run_User="www"
	wwwUser=$(cat /etc/passwd|cut -d ":" -f 1|grep ^www$)
	if [ "${wwwUser}" != "www" ];then
		groupadd ${Run_User}
		useradd -s /sbin/nologin -g ${Run_User} ${Run_User}
	fi

	password=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
	sleep 1
	admin_auth="/www/server/panel/data/admin_path.pl"
	if [ ! -f ${admin_auth} ];then
		auth_path=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
		echo "/${auth_path}" > ${admin_auth}
	fi
	auth_path=$(cat /dev/urandom | head -n 16 | md5sum | head -c 8)
	echo "/${auth_path}" > ${admin_auth}
	chmod -R 700 $pyenv_path/pyenv/bin
	/www/server/panel/pyenv/bin/pip3 install pymongo
	/www/server/panel/pyenv/bin/pip3 install psycopg2-binary
	/www/server/panel/pyenv/bin/pip3 install flask -U
	/www/server/panel/pyenv/bin/pip3 install flask-sock
	auth_path=$(cat ${admin_auth})
	cd ${setup_path}/server/panel/
	if [ "$SET_SSL" == true ]; then
        btpip install -I pyOpenSSl
        btpython /www/server/panel/tools.py ssl
    fi
	/etc/init.d/bt start
	$python_bin -m py_compile tools.py
	$python_bin tools.py username
	username=$($python_bin tools.py panel ${password})
	cd ~
	echo "${password}" > ${setup_path}/server/panel/default.pl
	chmod 600 ${setup_path}/server/panel/default.pl
	sleep 3
	/etc/init.d/bt restart 	
	sleep 3
	isStart=$(ps aux |grep 'BT-Panel'|grep -v grep|awk '{print $2}')
	LOCAL_CURL=$(curl 127.0.0.1:${panelPort}/login 2>&1 |grep -i html)
	if [ -z "${isStart}" ] && [ -z "${LOCAL_CURL}" ];then
		/etc/init.d/bt 22
		cd /www/server/panel/pyenv/bin
		touch t.pl
		ls -al python3.7 python
		lsattr python3.7 python
		Red_Error "ERROR: The BT-Panel service startup failed." "ERROR: 宝塔启动失败"
	fi
}
Set_Firewall(){
	sshPort=$(cat /etc/ssh/sshd_config | grep 'Port '|awk '{print $2}')
	if [ "${PM}" = "apt-get" ]; then
		apt-get install -y ufw
		if [ -f "/usr/sbin/ufw" ];then
			ufw allow 20/tcp
			ufw allow 21/tcp
			ufw allow 22/tcp
			ufw allow 80/tcp
			ufw allow 443/tcp
			ufw allow 888/tcp
			ufw allow ${panelPort}/tcp
			ufw allow ${sshPort}/tcp
			ufw allow 39000:40000/tcp
			ufw_status=`ufw status`
			echo y|ufw enable
			ufw default deny
			ufw reload
		fi
	else
		if [ -f "/etc/init.d/iptables" ];then
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 20 -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 21 -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport ${panelPort} -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport ${sshPort} -j ACCEPT
			iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 39000:40000 -j ACCEPT
			#iptables -I INPUT -p tcp -m state --state NEW -m udp --dport 39000:40000 -j ACCEPT
			iptables -A INPUT -p icmp --icmp-type any -j ACCEPT
			iptables -A INPUT -s localhost -d localhost -j ACCEPT
			iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
			iptables -P INPUT DROP
			service iptables save
			sed -i "s#IPTABLES_MODULES=\"\"#IPTABLES_MODULES=\"ip_conntrack_netbios_ns ip_conntrack_ftp ip_nat_ftp\"#" /etc/sysconfig/iptables-config
			iptables_status=$(service iptables status | grep 'not running')
			if [ "${iptables_status}" == '' ];then
				service iptables restart
			fi
		else
			AliyunCheck=$(cat /etc/redhat-release|grep "Aliyun Linux")
			[ "${AliyunCheck}" ] && return
			yum install firewalld -y
			[ "${Centos8Check}" ] && yum reinstall python3-six -y
			systemctl enable firewalld
			systemctl start firewalld
			firewall-cmd --set-default-zone=public > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=20/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=21/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=22/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=80/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=443/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=${panelPort}/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=${sshPort}/tcp > /dev/null 2>&1
			firewall-cmd --permanent --zone=public --add-port=39000-40000/tcp > /dev/null 2>&1
			#firewall-cmd --permanent --zone=public --add-port=39000-40000/udp > /dev/null 2>&1
			firewall-cmd --reload
		fi
	fi
}
Get_Ip_Address(){
	getIpAddress=""
	getIpAddress=$(curl -sS --connect-timeout 10 -m 60 https://www.bt.cn/Api/getIpAddress)
	if [ -z "${getIpAddress}" ] || [ "${getIpAddress}" = "0.0.0.0" ]; then
		isHosts=$(cat /etc/hosts|grep 'www.bt.cn')
		if [ -z "${isHosts}" ];then
			echo "" >> /etc/hosts
			getIpAddress=$(curl -sS --connect-timeout 10 -m 60 https://www.bt.cn/Api/getIpAddress)
			if [ -z "${getIpAddress}" ];then
				sed -i "/bt.cn/d" /etc/hosts
			fi
		fi
	fi

	ipv4Check=$($python_bin -c "import re; print(re.match('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$','${getIpAddress}'))")
	if [ "${ipv4Check}" == "None" ];then
		ipv6Address=$(echo ${getIpAddress}|tr -d "[]")
		ipv6Check=$($python_bin -c "import re; print(re.match('^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$','${ipv6Address}'))")
		if [ "${ipv6Check}" == "None" ]; then
			getIpAddress="SERVER_IP"
		else
			echo "True" > ${setup_path}/server/panel/data/ipv6.pl
			sleep 1
			/etc/init.d/bt restart
		fi
	fi

	if [ "${getIpAddress}" != "SERVER_IP" ];then
		echo "${getIpAddress}" > ${setup_path}/server/panel/data/iplist.txt
	fi
	LOCAL_IP=$(ip addr | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -E -v "^127\.|^255\.|^0\." | head -n 1)
}
Setup_Count(){
	curl -sS --connect-timeout 10 -m 60 https://www.bt.cn/Api/SetupCount?type=Linux\&o=$1 > /dev/null 2>&1
	if [ "$1" != "" ];then
		echo $1 > /www/server/panel/data/o.pl
		cd /www/server/panel
		$python_bin tools.py o
	fi
	echo /www > /var/bt_setupPath.conf
}
Install_Main(){
	#Set_Ssl
	startTime=`date +%s`
	Lock_Clear
	System_Check
	Get_Pack_Manager
	get_node_url

	MEM_TOTAL=$(free -g|grep Mem|awk '{print $2}')
	if [ "${MEM_TOTAL}" -le "1" ];then
		Auto_Swap
	fi
	
	if [ "${PM}" = "yum" ]; then
		Install_RPM_Pack
	elif [ "${PM}" = "apt-get" ]; then
		Install_Deb_Pack
	fi

	Install_Python_Lib
	Install_Bt
	

	Set_Bt_Panel
	Service_Add
	Set_Firewall

	Get_Ip_Address
	Setup_Count ${IDC_CODE}
}

echo "
+----------------------------------------------------------------------
| Bt-WebPanel FOR CentOS/Ubuntu/Debian
+----------------------------------------------------------------------
| Copyright © 2015-2099 BT-SOFT(http://www.bt.cn) All rights reserved.
+----------------------------------------------------------------------
| The WebPanel URL will be http://SERVER_IP:8888 when installed.
+----------------------------------------------------------------------
| 为了您的正常使用，请确保使用全新或纯净的系统安装宝塔面板，不支持已部署项目/环境的系统安装
+----------------------------------------------------------------------
"
while [ "$go" != 'y' ] && [ "$go" != 'n' ]
do
	read -p "Do you want to install Bt-Panel to the $setup_path directory now?(y/n): " go;
done

if [ "$go" == 'n' ];then
	exit;
fi

ARCH_LINUX=$(cat /etc/os-release |grep "Arch Linux")
if [ "${ARCH_LINUX}" ] && [ -f "/usr/bin/pacman" ];then
	pacman -Sy 
    pacman -S curl wget unzip firewalld openssl pkg-config make gcc cmake libxml2 libxslt libvpx gd libsodium oniguruma sqlite libzip autoconf inetutils sudo --noconfirm
fi

Install_Main

PANEL_SSL=$(cat /www/server/panel/data/ssl.pl 2> /dev/null)
if [ "${PANEL_SSL}" == "True" ];then
	HTTP_S="https"
else
	HTTP_S="http"
fi 

echo > /www/server/panel/data/bind.pl
echo -e "=================================================================="
echo -e "\033[32mCongratulations! Installed successfully!\033[0m"
echo -e "=================================================================="
echo  "外网面板地址: ${HTTP_S}://${getIpAddress}:${panelPort}${auth_path}"
echo  "内网面板地址: ${HTTP_S}://${LOCAL_IP}:${panelPort}${auth_path}"
echo -e "username: $username"
echo -e "password: $password"
echo -e "\033[33mIf you cannot access the panel,\033[0m"
echo -e "\033[33mrelease the following panel port [${panelPort}] in the security group\033[0m"
echo -e "\033[33m若无法访问面板，请检查防火墙/安全组是否有放行面板[${panelPort}]端口\033[0m"
if [ "${HTTP_S}" == "https" ];then
    echo -e "\033[33m因已开启面板自签证书，访问面板会提示不匹配证书，请参考以下链接配置证书\033[0m"
	echo -e "\033[33mhttps://www.bt.cn/bbs/thread-105443-1-1.html\033[0m"
fi
echo -e "=================================================================="

endTime=`date +%s`
((outTime=($endTime-$startTime)/60))
echo -e "耗时：\033[32m $outTime \033[0mMinute! "
