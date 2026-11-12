#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

rm -rf info &>/dev/null

echo -e "${GREEN}Проверка прав доступа..." 
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Скрипт должен быть запущен root пользователем${NC}"
    exit 1;
fi

echo -e "${CYAN}Сбор информации об установленных пакетах...${NC}"
if command -v dpkg &>/dev/null; then
    dpkg -l >> info && echo -e "${GREEN}Успешно сохранено${NC}" || echo -e "${RED}Ошибка сохранения${NC}"
else
    echo -e "${YELLOW}dpkg не найден${NC}"
fi

echo "" >> info

echo -e "${CYAN}Сбор информации о запущенных процессах...${NC}"
if command -v ps aux &>/dev/null; then
    ps aux >> info && echo -e "${GREEN}Успешно сохранено${NC}" || echo -e "${RED}Ошибка сохранения${NC}"
else
    echo -e "${YELLOW}ps не найден${NC}"
fi

echo "" >> info

echo -e "${CYAN}Сбор информации об открытых портах...${NC}"
if command -v netstat -tulpn &>/dev/null; then
    netstat -tulpn >> info && echo -e "${GREEN}Успешно сохранено${NC}" || echo -e "${RED}Ошибка сохранения${NC}"
elif command -v ss -tulpn &>/dev/null; then
    ss -tulpn >> info && echo -e "${GREEN}Успешно сохранено${NC}" || echo -e "${RED}Ошибка сохранения${NC}"
else
    echo -e "${YELLOW}netstat и ss  не найдены${NC}"
fi

echo "" >> info

echo -e "${CYAN}Установка пакетов «cowsay» и «sl»${NC}"
apt-get update >/dev/null;
if apt-get install -y cowsay >/dev/null 2>&1; then
  echo -e "Установлен пакет cowsay" >> info
else
  echo -e "${RED}Ошибка установки cowsay${NC}"
fi

echo "" >> info

if apt-get install -y sl >/dev/null 2>&1; then
  echo "Установлен пакет sl" >> info
else
  echo -e "${RED}Ошибка установки sl${NC}"
fi

echo "" >> info

echo -e "${CYAN}Сбор информации о версии ядра и ОС...${NC}"
echo "Версия ядра: $(uname -r) $(uname -v)" >> info 
echo "ОС: $(lsb_release -a)" >> info
echo -e "${GREEN}Успешно${NC}"

echo -e "${BLUE}Создание архива с результатами...${NC}"
if tar -cf OS_RESULT.tar info 2>/dev/null; then
    echo -e "${GREEN}Архив создан${NC}"
else
    echo -e "${RED}Ошибка создания архива${NC}"
fi

echo -e "${CYAN}Выполнение завершено${NC}"

