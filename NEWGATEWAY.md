 Einen neuen Gateway aufsetzen
===============================
 Long Story short:
----
 1. Der Gateway ist erreichbar?
  + Dort läuft eine aktuelle Debian-Version?
  + der user ``ansible`` exestiert und darf sudo ausführen?
  + der public SSH Keys deiner Maschiene ist sowohl in diesem ansible hinterlegt, als auch auf dem neuen System beim User ansible?
 2. Unter ``ansible/hosts`` ist der neue Gateway eingetragen?
  + Ggf. DNS Eintrag setzen
 3. ``hostvars/$hostname`` enthält alle host-spezifischen Angaben für das neue Gateway?
 4. ``$hostname.yml`` enthält das neue Playbook für den neuen Gateway?
 5. Interface ist unter ``roles/network/files/interfaces_$hostname.conf`` hinterlegt? 
 6. **Ansible ausführen!** 
```bash
ansible-playbook $hostname.yml
```
 7. Mögliche auftretende Fehler beheben und zurück melden
 
 TL; DR
========

Um einen neuen Gateway aufzusetzen ist einiges zu tun. Wir gehen mal davon aus, dass es sich bei dem Gateway um ein Debian handelt. Zum Beispiel Debian 9.
Auf deinem Computer ist ein beliebiges Linux mit einer relativ aktuellen Version von [Ansible](https://ansible.org/).
 
 Wie heißt der neue Gateway?
---
Der neue Gateway ist bestimmt schon im DNS hinterlegt? Sonst können L3D oder Mart das auch noch kurz machen!
Dieser Gateway braucht dann sein eigenes .yml File. Dieses kann man zB. anhand andere Gateways kopieren und anpassen.
Auch die hostvars müssen für jeden host angegeben sein.
Optional kommt es natürlich auch gut, wenn man dem Gateway selber auch diesen Hostname gibt. Dieser wird unter ``/etc/hostname`` gespeichert. 
Und natürlich muss dieser Host auch unter ``ansible/hosts`` unter der Gruppe Freifunk hinzugefügt werden. Optional auch gleich mit IPv6 Adresse.

 * hostname.yml erstellen/kopieren und anpassen
 * hostvars/hostname erstellen/kopieren und anpassen
 * Host unter ansible/hosts hinzufügen

 Auf dem Gateway
---
Auf dem Gateway selber muss von Hand eigendlich nicht viel gemacht werden. Am einfachsten für das Ansible wäre es, wenn es den Benutzer ``ansible`` gibt. Dieser Benutzer braucht kein Passwort zu haben. Er sollte aber Superkräfte *(sudo/root)* haben. Und unter ``~/.ssh/authorized_keys`` sollte selbstverständlich euer Public SSH Key liegen.
Und um Ansible wirklich auf dem Gateway benutzen zu können, muss dort auch Python installiert sein. Dies alles kann zum Beispiel so gemacht werden:

````bash
adduser --disabled-password \
  --shell /bin/bash \
  --gecos "" \
  ansible

apt install sudo
echo 'ansible ALL=NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

mkdir /home/ansible/.ssh
echo "YOUR SSH-KEY" > /home/ansible/.ssh/authorized_keys
chmod -R 700 /home/ansible/.ssh
chown -R ansible.ansible /home/ansible/.ssh

apt install python

````

 Netzwerk
---
Natürlich möchte das Netzwerk auch verwaltet werden. Hier ist es ratsam sich die Datei ``/etc/network/interfaces`` als Vorbild zu nehmen und diese *(ggf. leicht modifiziert)* hier im Ansible unter roles/network/files/interfaces_hostname ablegen.

 * Das Netzwerkinterface unter roles/network/files/interfaces_hostname speichern

##Ansible ausführen
Nun muss eigendlich nur noch das Ansible ausgeführt werden...
Im idealfall funktioniert das reibungslos. Andernfalls hat man meistens eine Fehlerbeschreibung die einem sagt, was man vergessen hat.
Beim Ausführen von Ansible wird u.A. der authorized_key aller hinterlegten User wie root, ansible o.ä. geändert. Achte also darauf, dass du dich dabei nicht ausspeerst.

Um das Ansible zu starten gebe folgendes ein:

````bash
ansible-playbook hostname.yml
````

**Bei Fragen oder Unsicherheiten frag einfach auf Hackint im Channel [#ffbsee](https://webirc.hackint.org/#irc://irc.hackint.org/#ffbsee) nach.** Am besten du pingst dort direkt den L3D oder mart.
