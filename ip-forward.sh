#!/bin/bash

# Written By: wizwiz

echo -e "\e[94m
=================================================================
    Telegram Channel: @wizwizch | Telegram Group: @wizwizdev
=================================================================
\033[0m"

wait

# install 
sudo apt-get install iptables -y
sudo apt update && apt upgrade -y

wait

read -p "Enter ip iran: " ipiran
if [ "$ipiran" = "" ]; then
exit
fi
read -p "Enter port iran: " portiran
if [ "$portiran" = "" ]; then
exit
fi
read -p "Enter ip kharej: " ipkharej
if [ "$ipkharej" = "" ]; then
exit
fi

# variables
ip_iran="$ipiran"
ip_kharej="$ipkharej"
port_iran="$portiran"


sysctl net.ipv4.ip_forward=1
iptables -t nat -A PREROUTING -p tcp --dport $portiran -j DNAT --to-destination $ipiran
iptables -t nat -A PREROUTING -j DNAT --to-destination $ipkharej
iptables -t nat -A POSTROUTING -j MASQUERADE

echo "#!/bin/sh -e" >> /etc/rc.local
echo "sysctl net.ipv4.ip_forward=1" >> /etc/rc.local
echo "iptables -t nat -A PREROUTING -p tcp --dport ${portiran} -j DNAT --to-destination ${ipiran}" >> /etc/rc.local
echo "iptables -t nat -A PREROUTING -j DNAT --to-destination ${ipkharej}" >> /etc/rc.local
echo "iptables -t nat -A POSTROUTING -j MASQUERADE" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local

chmod +x /etc/rc.local

wait

echo -e "\n\e[92mSet successfully!\033[0m\n"



