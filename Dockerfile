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

# Создание общего секрета для StrongSwan
RUN SHARED_SECRET="123$(dd if=/dev/urandom count=1 bs=32 2>/dev/null | base64)" \
    && echo ": PSK \"${SHARED_SECRET}\"" > /etc/ipsec.secrets

# Удаление файла starter.charon.pid
RUN rm -f /var/run/starter.charon.pid

# Задаем точку входа для контейнера - запуск VPN
ENTRYPOINT ["start-vpn"]
