#!/bin/bash

DATADIR=/opt/freifunk/icvpn-meta

# Update ICVPN stuff from git

cd $DATADIR
/usr/bin/git pull -q

cd /opt/freifunk/icvpn-scripts
/usr/bin/git pull -q

echo "ICVPN git updates done"

sudo -u nobody /opt/freifunk/icvpn-scripts/mkbgp -4 -f bird -d peers -p icvpn_ -s "$DATADIR" -x {{ community }} > /etc/bird/bird.d/icvpn.conf
sudo -u nobody /opt/freifunk/icvpn-scripts/mkbgp -6 -f bird -d peers -p icvpn_ -s "$DATADIR" -x {{ community }} > /etc/bird/bird6.d/icvpn.conf

birdc configure > /dev/null
birdc6 configure > /dev/null

echo "ICVPN bird conf done"

# refresh DNS config for freifunk zones
sudo -u nobody /opt/freifunk/icvpn-scripts/mkdns -f unbound -s "$DATADIR" -x bodensee -x bodensee2 > /etc/unbound/unbound.conf.d/freifunk_forward_zones.conf

# restart unbound
systemctl restart unbound > /dev/null

{% if run_icvpn == 'true' %}
rndc reload > /dev/null

sudo -u nobody /opt/freifunk/icvpn-scripts/mkbgp -4 -f bird -d peers -s "$DATADIR" -x {{ community }} > /etc/bird/bird.d/icvpn.conf
sudo -u nobody /opt/freifunk/icvpn-scripts/mkbgp -6 -f bird -d peers -s "$DATADIR" -x {{ community }} -t berlin:upstream > /etc/bird/bird6.d/icvpn.conf

birdc configure > /dev/null
birdc6 configure > /dev/null

{% endif %}
