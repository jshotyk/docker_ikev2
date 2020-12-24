FROM alpine:3.12

LABEL tags="alpine-3.12" \
      build_ver="23-12-2020"

RUN apk add --no-cache \
    curl=7.69.1-r3 \
    openssl=1.1.1i-r0 \
    util-linux=2.35.2-r0 \
    strongswan=5.8.4-r2 \
    && rm -rf /var/cache/apk/* \
    && rm -f /etc/ipsec.secrets

ADD ./etc/* /etc/
ADD ./bin/* /usr/bin/

EXPOSE 500/udp 4500/udp

CMD /usr/bin/start-vpn

