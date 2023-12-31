#!/bin/bash
#update/upgrade script for debian 10/11/12
#Written by Shawn Falconbury
#Written 01 June 2021
#Updated 27 March 2022
#Updated 27 August 2023
#
#
echo "" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------Begin-----------------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------File System Check-----------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo sudo df -h| grep 'Filesystem\|/dev/sda*' >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------Memory Check----------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo sudo free -h | grep -v + >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------Connection checks-----------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo nmcli connection show --active >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------Speed Check-----------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo speedtest >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------System Updates--------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo apt-get update -y >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------System Upgrades-------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo apt-get upgrade -y >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------Upgrade Cleanup-------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo apt-get autoremove -y >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "--------------------------------Snap Upgrade Check----------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
	sudo snap refresh >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "------------------------------------------------------------------------------" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo -e "update/upgrade checks completed for $(date)..." >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
echo "#################################END##########################################" >> ~/logs/update/"update-check-$(date +"%y%m%d").log"
