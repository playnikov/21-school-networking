#!/bin/bash

column1_background=$1
column1_font_color=$2
column2_background=$3
column2_font_color=$4

. ./color.sh $1 $2 $3 $4

echo -e "${background_name}${font_name}HOSTNAME${end} = ${background_value}${font_value}$HOSTNAME${end}"
echo -e "${background_name}${font_name}TIMEZONE${end} = ${background_value}${font_value}$(timedatectl | grep zone | awk '{print $3, $4, $5}')${end}"
echo -e "${background_name}${font_name}USER${end} = ${background_value}${font_value}$USER${end}"
echo -e "${background_name}${font_name}OS${end} = ${background_value}${font_value}$(cat /etc/issue | awk '{printf("%s %s %s",$1,$2,$3)}')${end}"
echo -e "${background_name}${font_name}DATE${end} = ${background_value}${font_value}$(date +"%d %b %Y %H:%M:%S")${end}"
echo -e "${background_name}${font_name}UPTIME${end} = ${background_value}${font_value}$(uptime -p)${end}"
echo -e "${background_name}${font_name}UPTIME_SEC${end} = ${background_value}${font_value}$(awk '{print $1}' /proc/uptime)${end}"
echo -e "${background_name}${font_name}IP${end} = ${background_value}${font_value}$(hostname -I)${end}"
echo -e "${background_name}${font_name}MASK${end} = ${background_value}${font_value}$(ip a | grep inet | grep brd | awk '{print $4}')${end}"
echo -e "${background_name}${font_name}GATEWAY${end} = ${background_value}${font_value}$(ip route | grep default | awk '{print $3}')${end}"
echo -e "${background_name}${font_name}RAM_TOTAL${end} = ${background_value}${font_value}$(free -m | grep Mem | awk '{printf("%.3f\n",$2 / 1024)}') GB${end}"
echo -e "${background_name}${font_name}RAM_USED${end} = ${background_value}${font_value}$(free -m | grep Mem | awk '{printf("%.3f\n",$3 / 1024)}') GB${end}"
echo -e "${background_name}${font_name}RAM_FREE${end} = ${background_value}${font_value}$(free -m | grep Mem | awk '{printf("%.3f\n",$4 / 1024)}') GB${end}"
echo -e "${background_name}${font_name}SPACE_ROOT${end} = ${background_value}${font_value}$(df -hk | grep "\/$" | awk '{printf("%.2f\n",$2 / 1024)}') MB${end}"
echo -e "${background_name}${font_name}SPACE_ROOT_USED${end} = ${background_value}${font_value}$(df -hk | grep "\/$" | awk '{printf("%.2f\n",$3 / 1024)}') MB${end}"
echo -e "${background_name}${font_name}SPACE_ROOT_FREE${end} = ${background_value}${font_value}$(df -hk | grep "\/$" | awk '{printf("%.2f\n",$4 / 1024)}') MB${end}"