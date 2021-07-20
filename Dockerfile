FROM alpine:3.14

LABEL tags="alpine-3.14" \
      build_ver="20-07-2021"

COPY etc /etc
COPY usr/bin /usr/bin

RUN apk add --no-cache \
    strongswan=5.9.1-r1 \
    && rm -rf /var/cache/apk/* \
    && rm -f /etc/ipsec.secrets

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["start-vpn"]

