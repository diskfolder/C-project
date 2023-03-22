/斌/庆典
回声 “ ##################################### ”
echo  " youtube-channel: 云白科技"
echo  "作者：云百科技"
回声 “ ##################################### ”
echo  "开始安装"
echo  "如果安装失败了,把这个codespace删了,重新开一个"
睡觉 2
echo  "安装宝塔面板"
如果[ -f /usr/bin/curl ] ; 然后curl -sSO https://download.bt.cn/install/install_panel.sh ；else wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh ; ；_ bash install_panel.sh ed8484bec

echo  "第二步,破解宝塔面板"
睡觉 3
bash btvip.sh
睡觉 2
echo  "最后一步"

rm -f /www/server/panel/data/admin_path.pl


