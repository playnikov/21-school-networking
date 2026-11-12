#!/bin/bash

echo "HOSTNAME = "$HOSTNAME
echo "TIMEZONE = $(timedatectl | grep zone | awk '{print $3 $4 $5}')"
echo "USER = $USER"
echo "OS = $(cat /etc/issue)"
echo "DATE = $(date +"%d %b %Y %H:%M:%S")"
echo "UPTIME = $(uptime -p)"
echo "UPTIME_SEC = $(awk '{print $1}' /proc/uptime)"
echo "IP = $(hostname -I)"
echo "MASK = $(ip a | grep inet | grep brd | awk '{print $4}')"
echo "GATEWAY = $(ip route | grep default | awk '{print $3}')"
echo "RAM_TOTAL = $(free -m | grep Mem | awk '{printf("%.3f\n",$2 / 1024)}') GB"
echo "RAM_USED = $(free -m | grep Mem | awk '{printf("%.3f\n",$3 / 1024)}') GB"
echo "RAM_FREE = $(free -m | grep Mem | awk '{printf("%.3f\n",$4 / 1024)}') GB"
echo "SPACE_ROOT = $(df -hk | grep "\/$" | awk '{printf("%.2f\n",$2 / 1024)}') MB"
echo "SPACE_ROOT_USED = $(df -hk | grep "\/$" | awk '{printf("%.2f\n",$3 / 1024)}') MB"
echo "SPACE_ROOT_FREE = $(df -hk | grep "\/$" | awk '{printf("%.2f\n",$4 / 1024)}') MB"