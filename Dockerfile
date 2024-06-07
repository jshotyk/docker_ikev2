FROM alpine:latest

# Переключаемся на пользователя root
USER root

# Копируем необходимые конфигурационные файлы и исполняемые файлы в контейнер
COPY etc /etc
COPY bin /usr/bin

# Добавляем репозиторий для установки пакетов из тестовой ветки Alpine Linux
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Устанавливаем необходимые пакеты: strongswan, iptables и удаляем кэш
RUN apk add --no-cache strongswan iptables \
    && rm -rf /var/cache/apk/* \
    && rm -f /etc/ipsec.secrets

# Обновляем пакет awall
RUN apk add -u awall

# Открываем порты 500/udp и 4500/udp
EXPOSE 500/udp 4500/udp

# Задаем точку входа для контейнера - запуск VPN
ENTRYPOINT ["start-vpn"]
