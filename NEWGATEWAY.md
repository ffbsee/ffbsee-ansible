Einen neuen Gateway aufsetzen
=============================

Long Story short
----------------

 1. Der Gateway ist erreichbar?
  + Dort läuft eine aktuelle Debian-Version?
  + Der user `ansible` exestiert und darf `sudo` ausführen?
  + Der SSH Public-Key deiner Maschine ist in diesem ansible git repository unter `files/admin_ssh_keys/` hinterlegt?
  + Der SSH Public-Key deiner Maschine ist auf dem neuen System beim User `ansible` im `~/.ssh/authorized_keys` file?
 2. Unter `ansible/hosts` ist der neue Gateway eingetragen?
  + Gegebenenfalls DNS Eintrag setzen
 3. `hostvars/$hostname` enthält alle host-spezifischen Angaben für das neue Gateway?
 4. `$hostname.yml` enthält das neue Playbook für den neuen Gateway?
 5. Die Netzwerk Interface Konfiguration ist unter ``roles/network/files/interfaces_$hostname.conf`` hinterlegt?
 6. **Ansible ausführen!** per `ansible-playbook $hostname.yml`
 7. Mögliche auftretende Fehler beheben und zurück melden


Im Detail
=========

Um einen neuen Gateway aufzusetzen ist einiges zu tun. Wir gehen mal davon aus, dass es sich bei dem Gateway um ein [Debian](https://www.debian.org) handelt. Zum Beispiel ein Debian 9 (Stretch). Auf deinem Computer ist ein beliebiges Linux mit einer relativ aktuellen Version von [Ansible](https://ansible.org/).


Wie heißt der neue Gateway?
---------------------------

Der neue Gateway ist bestimmt schon im DNS hinterlegt? Sonst können L3D oder Mart das auch noch kurz machen! Dieser Gateway braucht dann sein eigenes `.yml` File. Dieses kann man zum Beispiel von anderen Gateways kopieren und anpassen. Auch die `hostvars` müssen für jeden host angegeben sein. Es kommt natürlich gut, wenn man dem Gateway selber auch diesen Hostname gibt. Dieser wird unter `/etc/hostname` gespeichert. Und natürlich muss dieser Host auch unter `ansible/hosts` unter der Gruppe `freifunk` hinzugefügt werden.

 * `hostname.yml` erstellen oder kopieren und anpassen
 * `hostvars/hostname` erstellen oder kopieren und anpassen
 * Host unter `ansible/hosts` hinzufügen


Auf dem Gateway
---------------

Auf dem Gateway selber muss von Hand nicht viel gemacht werden. Am einfachsten für das Ansible ist es, wenn es den Benutzer `ansible` gibt. Dieser Benutzer soll kein Passwort haben.

```bash
adduser --disabled-password --shell /bin/bash --gecos "" ansible
```

Er sollte aber Superkräfte *(sudo/root)* haben. Und unter `~/.ssh/authorized_keys` sollte selbstverständlich dein SSH Public-Key liegen.

```bash
apt update
apt install sudo curl
echo 'ansible ALL=NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

mkdir /home/ansible/.ssh
curl "https://raw.githubusercontent.com/ffbsee/ansible/master/files/admin_ssh_keys/l3d_id.pub" > /home/ansible/.ssh/authorized_keys # Add your SSH Key
chmod -R 700 /home/ansible/.ssh
chown -R ansible.ansible /home/ansible/.ssh
```

Und um Ansible wirklich auf dem Gateway benutzen zu können, muss dort Python installiert sein. Dies alles kann zum Beispiel so gemacht werden:

```bash
apt install python
```

Netzwerk
--------

Natürlich möchte das Netzwerk auch verwaltet werden. Hier ist es ratsam sich die Datei ``/etc/network/interfaces`` als Vorbild zu nehmen und diese *(ggf. leicht modifiziert)* hier im Ansible unter ``roles/network/files/interfaces_hostname`` ablegen.


Ansible ausführen
=================

Nun muss eigendlich nur noch das Ansible ausgeführt werden. Im idealfall funktioniert das reibungslos. Andernfalls hat man meistens eine Fehlerbeschreibung die einem sagt, was man vergessen hat. Beim Ausführen von Ansible wird unter Anderem das `authorized_key` file aller hinterlegten User wie `root`, `ansible` o.ä. geändert. Achte also darauf, dass du dich dabei nicht aussperrst!

Um das Ansible zu starten gib folgendes ein:

```bash
ansible-playbook hostname.yml
```

**Bei Fragen oder Unsicherheiten frag einfach auf Hackint im Channel [#ffbsee](https://webirc.hackint.org/#irc://irc.hackint.org/#ffbsee) nach.** Am besten du pingst dort direkt den L3D oder mart.
