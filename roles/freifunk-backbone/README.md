Hier werden die Dienste wie B.A.T.M.A.N installiert.

Um eine Neuinstallation zu forcen muss die auf dem node heruntergeladene tar gelöscht werden.

## Wie
```bash
sudo su -
rm /root/download/batman-adv.*.tar.gz
```

Sieh auch [im Ansible](https://github.com/ffbsee/ffbsee-ansible/blob/master/roles/freifunk-backbone/tasks/main.yml#L29-L34)
