FROM alpine:3.13

LABEL tags="alpine-3.13" \
      build_ver="15-01-2021"

COPY etc /etc
COPY usr/bin /usr/bin

RUN apk add --no-cache \
    strongswan=5.9.1-r0 \
    && rm -rf /var/cache/apk/* \
    && rm -f /etc/ipsec.secrets

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["start-vpn"]

