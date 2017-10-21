FROM wppier/cron:latest as cron

FROM certbot/certbot:latest

LABEL name="wppier/certbot"
LABEL version="0.0.1"

COPY --from=cron /usr/local/bin/supercronic /usr/local/bin/supercronic

# Copy all needed files
COPY /files/ /

RUN pip install certbot-dns-cloudflare --user

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["supercronic", "/etc/supercronic/cron"]