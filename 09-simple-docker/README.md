# Simple Docker

Знакомство с Docker: готовые образы, операции с контейнером, собственный образ на nginx, проверка через dockle и запуск через Docker Compose.

## Содержимое

| Путь | Что это |
|------|---------|
| `REPORT.md` | Отчёт по шести частям задания со скриншотами |
| `images/` | Скриншоты выполнения |
| `nginx.conf` | Базовая конфигурация nginx для контейнера |
| `Part3/` | Мини-веб-сервер: `server.c`, `nginx.conf`, скрипты сборки и очистки |
| `Part4/` | Собственный образ: `Dockerfile`, `server.c`, `nginx.conf`, `build.sh`, `start.sh`, `clean.sh` |
| `Part5/` | Проверка образа через dockle: доработанный `Dockerfile` и тот же набор скриптов |
| `Part6/` | Docker Compose: `docker-compose.yaml`, свой `nginx.conf`, каталог `logs/` с access и error логами |
