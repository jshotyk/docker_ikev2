FROM alpine:3.16

LABEL tags="alpine-3.16" \
      build_ver="24-05-2022"

COPY etc /etc
COPY usr/bin /usr/bin

RUN apk add --no-cache \
                strongswan=5.9.5-r1 \
                    && rm -rf /var/cache/apk/* \
                    && rm -f /etc/ipsec.secrets

EXPOSE 500/udp 4500/udp

ENTRYPOINT ["start-vpn"]

