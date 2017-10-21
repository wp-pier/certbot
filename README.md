Currently only supports cert creation using the dns-cloudflare plugin

Set the following environment vars:

DOMAINS: a space separated list of domains for which you want to generate certificates.
EMAIL: where you will receive updates from letsencrypt.
SEPARATE: true or false, whether you want one certificate per domain or one certificate valid for all domains.
CF_CREDENTIALS_FILE: path to an ini file containing
```
dns_cloudflare_email = email@example.com
dns_cloudflare_api_key = SOMEKEY09807adh432a9d9e9f9 
```