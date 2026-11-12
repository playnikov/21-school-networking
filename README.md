# Учебные проекты: сети, Linux и DevOps

Репозиторий с выполненными проектами по сетям, администрированию Linux/Windows, Docker и CI/CD.
Здесь собраны только решения — формулировки заданий, методички и служебные файлы платформы обучения не публикуются.

## Содержание

| № | Каталог | Проект | Основные темы |
|---|---------|--------|---------------|
| 01 | [01-networking-basics-part-1](01-networking-basics-part-1/) | Основы сетей. Часть 1 | Модель OSI/TCP-IP, IP и маски, ARP, ICMP, multicast, GNS3 |
| 02 | [02-networking-basics-part-2](02-networking-basics-part-2/) | Основы сетей. Часть 2 | Статическая маршрутизация, NTP, DNS, DHCP, SSH |
| 03 | [03-networking-basics-part-3](03-networking-basics-part-3/) | Основы сетей. Часть 3 | VLAN, агрегирование каналов, динамическая маршрутизация, резервирование |
| 04 | [04-networking-basics-part-4](04-networking-basics-part-4/) | Основы сетей. Часть 4 | Анализ дампов Wireshark/tcpdump, reverse shell, Scapy |
| 05 | [05-linux-basics](05-linux-basics/) | Основы Linux | Сбор информации о системе, пользователи и права, Postfix, SSH, iptables |
| 06 | [06-windows-basics](06-windows-basics/) | Основы Windows | Политики безопасности, BitLocker, аудит, правила брандмауэра |
| 07 | [07-linux-network](07-linux-network/) | Linux Network | ipcalc, статическая маршрутизация, iperf3, iptables, DHCP, NAT, SSH-туннели |
| 08 | [08-linux-monitoring](08-linux-monitoring/) | Linux Monitoring | Bash-скрипты, сбор метрик системы, цветной вывод, анализ файловой системы |
| 09 | [09-simple-docker](09-simple-docker/) | Simple Docker | Образы и контейнеры, собственный Dockerfile, dockle, Docker Compose |
| 10 | [10-cicd](10-cicd/) | Basic CI/CD | GitLab Runner, стадии сборки и тестов, деплой, уведомления, собственные утилиты `cat` и `grep` на C |

## Структура

```
.
├── 01-networking-basics-part-1/   GNS3-проекты, дампы ARP/multicast, расчёт адресов
├── 02-networking-basics-part-2/   GNS3-проекты и дампы DHCP, DNS, NTP, SSH
├── 03-networking-basics-part-3/   GNS3-проекты (VLAN, LACP, OSPF, HSRP)
├── 04-networking-basics-part-4/   Разбор трафика, отчёт, скрипт на Scapy
├── 05-linux-basics/               Bash-скрипты, конфиги Postfix/SSH/iptables, архив с отчётом
├── 06-windows-basics/             PowerShell-скрипты и выгрузки политик безопасности
├── 07-linux-network/              Отчёт с экранами и схемой сети
├── 08-linux-monitoring/           Набор bash-скриптов по частям 01–05
├── 09-simple-docker/              Dockerfile, nginx.conf, docker-compose, отчёт
└── 10-cicd/                       Утилиты cat/grep на C с тестами, скрипты пайплайна, отчёт
```

## Инструменты

- **GNS3** + образы Cisco IOS — для сетевых топологий (`.gns3`).
- **Wireshark / tcpdump** — для файлов `.pcap` и `.pcapng`.
- **Debian / Kali Linux**, **bash** — для скриптов и системных отчётов.
- **Docker**, **docker-compose**, **dockle** — для проекта про контейнеры.
- **GitLab CI** (`gitlab-runner`) — для пайплайна.
- **PowerShell** — для проекта по Windows.
- **Python 3 + Scapy** — для генерации пакетов.
