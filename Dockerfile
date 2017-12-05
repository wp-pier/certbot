FROM wppier/cron:latest as cron

FROM alpine:3.6

RUN apk add --no-cache --virtual .certbot-run-deps \
        python                                     \
        py-setuptools                              \
        py-acme                                    \
        py-argparse                                \
        py-certifi                                 \
        py-cffi                                    \
        py-chardet                                 \
        py-configargparse                          \
        py-configobj                               \
        py-cryptography                            \
        py-dialog                                  \
        py-enum34                                  \
        py-future                                  \
        py-idna                                    \
        py-ipaddress                               \
        py-mock                                    \
        py-openssl                                 \
        py-packaging                               \
        py-parsedatetime                           \
        py-requests                                \
        py-rfc3339                                 \
        py-setuptools                              \
        py-six                                     \
        py-tz                                      \
        py-zope-component                          \
        py-zope-event                              \
        py-zope-interface

ARG CERTBOT_VERSION=0.19.0

RUN apk add --no-cache --virtual .certbot-build-deps \
        py-pip                                       \
        gcc                                          \
        python-dev                                   \
        musl-dev                                     \
        libffi-dev                                   \
        openssl-dev                                &&\
    pip install --no-cache-dir                       \
        certbot=="$CERTBOT_VERSION"                  \
        certbot-dns-cloudflare=="$CERTBOT_VERSION" &&\
    apk del --no-cache .certbot-build-deps

COPY --from=cron /usr/local/bin/supercronic /usr/local/bin/supercronic
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY run-certbot.sh /usr/local/bin/run-certbot.sh
COPY cron /etc/supercronic/cron

VOLUME ["/etc/letsencrypt"]

LABEL name="wppier/certbot"
LABEL version="latest"

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["supercronic", "/etc/supercronic/cron"]
