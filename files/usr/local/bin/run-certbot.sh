#!/bin/sh
set -eu

echo "Running certbot for domains $DOMAINS"

get_certificate() {
  # Gets the certificate for the domain(s) CERT_DOMAINS (a comma separated list)
  # The certificate will be named after the first domain in the list
  # To work, the following variables must be set:
  # - CERT_DOMAINS : comma separated list of domains
  # - EMAIL

  local d=${CERT_DOMAINS//,*/} # read first domain
  echo "Getting certificate for $CERT_DOMAINS"
  certbot certonly --dns-cloudflare --agree-tos --renew-with-new-domains --keep-until-expiring -n \
  --dns-cloudflare-credentials $CF_CREDENTIALS_FILE --email $EMAIL -d $CERT_DOMAINS
  ec=$?
  echo "certbot exit code $ec"
  if [ $ec -eq 0 ]
  then
    echo "Certificate obtained for $CERT_DOMAINS!"
  else
    echo "Cerbot failed for $CERT_DOMAINS. Check the logs for details."
  fi
}

if [ "${SEPARATE:-false}" != "false"  ];
then
  for d in $DOMAINS
  do
    CERT_DOMAINS=$d
    get_certificate
  done
else
  CERT_DOMAINS=${DOMAINS// /,}
  get_certificate
fi