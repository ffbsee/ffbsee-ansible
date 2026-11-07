# apache-sites

Apache-vhosts mit je eigenem Let's-Encrypt-Zertifikat pro Name.

- `apache_sites` (host_vars): pro Eintrag `name`, `docroot`, optional
  `aliases` (kommen mit ins Zertifikat), `php`, `icingaweb2`
- Port 80 leitet auf https um, außer `/.well-known/acme-challenge/`
- Zertifikate per `certbot certonly --webroot` in ein gemeinsames Verzeichnis
  (`apache_sites_acme_webroot`); Apache läuft dabei weiter
- neu beantragt wird nur, wenn ein Zertifikat fehlt, abgelaufen ist, andere
  Namen enthält oder nicht per webroot erneuert wird
- Erneuerung über `certbot.timer`; der Deploy-Hook lädt Apache neu und
  übernimmt bei `apache_sites_unifi_cert_name` das Zertifikat in den
  UniFi-Keystore
- kaputte Renewal-Configs der verwalteten Namen (`certbot certificates`
  meldet sie als invalid) werden samt live/archive entfernt
- der alte Cron-Eintrag `renew_letsencrypt.sh` in `/etc/crontab` wird entfernt

```bash
ansible-playbook freifunk.ffbsee.yml --tags apache-sites --limit mate.ffbsee.net --check --diff
```
