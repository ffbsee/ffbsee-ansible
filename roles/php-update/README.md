# php-update

Gezieltes Sicherheitsupdate für PHP, nur mit `--tags php-update`.

- aktualisiert die installierten Pakete, die auf `php_update_package_pattern`
  passen (`apt --only-upgrade`, es wird nichts neu installiert)
- startet `apache2` bzw. `php8.x-fpm` neu, wenn sie laufen (kurzer Ausfall)
- prüft `php8.x-common` gegen `php_update_min_versions` und schlägt fehl,
  wenn ein Zweig darunter liegt; Zweige ohne Mindeststand (z. B. 8.1, upstream
  ohne Fix) werden nur gemeldet
- Hosts ohne PHP bleiben unverändert

`--check` zeigt, was aktualisiert würde, und den aktuellen Versionsstand.

Für ein neues Advisory reicht es, `php_update_min_versions` anzupassen.
