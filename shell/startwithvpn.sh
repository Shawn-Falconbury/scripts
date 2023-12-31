#!/bin/bash
#update/upgrade script for debian 10/11
#Written by Shawn Falconbury
#Written 01 June 2021
#Updated 20 March 2022
#
#
#
echo "--------------------------------BEGIN----------------------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "-------------------------------System Information----------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Hostname:\t\t"`hostname` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Serial Number:\t\t"`sudo cat /sys/class/dmi/id/product_serial` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Kernel:\t\t\t"`uname -r` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Architecture:\t\t"`arch` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Active User:\t\t"`w | cut -d ' ' -f1 | grep -v USER | xargs -n1` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "System Main IP:\t\t"`hostname -I` >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "" >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------Connection checks-----------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	sudo nmcli connection show --active >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------System checks---------------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	sudo speedtest >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------System updates--------------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	sudo apt-get update -y >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------System upgrades-------------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	sudo apt-get upgrade -y >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------upgrade cleanup-------------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	sudo apt-get autoremove -y >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------Start VPN connection--------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	protonvpn-cli c -f >> ~/logs/"start-check-$(date +"%y%m%d").log"
	protonvpn-cli status >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------Follow-up Connection checks-------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
	sudo nmcli connection show --active >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo -e "Daily startup checks completed for $(date)..." >> ~/logs/"start-check-$(date +"%y%m%d").log"
echo "--------------------------------END-------------------------------------------" >> ~/logs/"start-check-$(date +"%y%m%d").log"
