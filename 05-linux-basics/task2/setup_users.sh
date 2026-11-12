#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${CYAN}Проверка прав доступа..."
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Скрипт должен быть запущен root пользователем${NC}"
    exit 1;
fi

set -e

echo -e "${YELLOW}=== Создание групп пользователей ===${NC}"

echo -e "${CYAN}Создаётся default_users${NC}"
groupadd -f default_users

echo -e "${CYAN}Создаётся secret_users"
groupadd -f secret_users

echo -e "${YELLOW}=== Создание пользователей ===${NC}"
echo -e "${CYAN}Создание пользователя user${NC}"
useradd -m -s /bin/bash -G default_users user 2>/dev/null || echo -e "${YELLOW}Пользователь ${WHITE}user${YELLOW} уже существует.${NC}"

for username in secret_agent secret_spy secret_boss; do
	echo -e "${CYAN}Создание пользователя $username${NC}"
	if id "$username" &>/dev/null; then
		echo -e "${YELLOW}Пользователь ${WHITE}$username${YELLOW} уже существует.${NC}"
	else
		useradd -m -s /bin/bash -G secret_users $username 2>/dev/null
	fi
done

echo -e "${YELLOW}=== Настройка прав пользователей ===${NC}"
for username in secret_agent secret_spy secret_boss; do
    home_dir="/home/$username"
    if [ -d "$home_dir" ]; then
        chown "$username:secret_users" "$home_dir"
        chmod 770 "$home_dir"
        echo -e "${GREEN}Настроены права для $home_dir${NC}"
    fi
done

chmod 777 /var
echo -e "${GREEN}Настроены права для /home/user${NC}"

echo -e "${YELLOW}=== Установка apache2 ===${NC}"
apt-get update >/dev/null;
if apt-get install -y apache2 >/dev/null 2>&1; then
  echo -e "${GREEN}Установлен пакет apache2${NC}"
  service apache2 start
  systemctl status apache2 --no-pager
else
  echo -e "${RED}Ошибка установки apache2${NC}"
fi

echo -e "${YELLOW}=== Настройка sudo для группы default_users ===${NC}"
grep -q "%default_users ALL=(ALL) NOPASSWD: ALL" /etc/sudoers || echo '%default_users ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
chmod 440 /etc/sudoers
echo -e "${GREEN}Выполнение завершено${NC}"
