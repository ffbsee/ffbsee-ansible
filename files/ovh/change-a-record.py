#!/usr/bin/python
# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''
import json
import ovh
import sys
from requests import get
import dns.resolver
import configparser
config = configparser.ConfigParser()
config.read('/etc/ovh.conf')

# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page
client = ovh.Client(
    endpoint=str(config.get('default', 'endpoint')),               # Endpoint of API OVH Europe (List of available endpoints)
    application_key=str(config.get('set-dns', 'application_key')),    # Application Key
    application_secret=str(config.get('set-dns', 'application_secret')), # Application Secret
    consumer_key=str(config.get('set-dns', 'consumer_key')),       # Consumer Key
)

ip = get('https://api.ipify.org').text
answer = dns.resolver.query('speedtest.gw02.ffbsee.net','A')
for server in answer:
     arecord = server
print "Current A record:", arecord
print "Our real IPv4:", ip

if str(arecord) == str(ip):
    print "current IP matches A-record - nothing to do"
    exit()   

result = client.put('/domain/zone/ffbsee.net/record/1527075158', 
    target=ip,
    ttl=60, 
    subDomain='speedtest.gw02', 
)
# Pretty print
print json.dumps(result, indent=4)

from requests import get

print 'Set A-record for speedtest.gw02.ffbsee.net in ovh DNS', ip

client = ovh.Client(
    endpoint=str(config.get('default', 'endpoint')),               # Endpoint of API OVH Europe (List of available endpoints)
    application_key=str(config.get('set-zone', 'application_key')),    # Application Key
    application_secret=str(config.get('set-zone', 'application_secret')), # Application Secret
    consumer_key=str(config.get('set-zone', 'consumer_key')),       # Consumer Key
)

result = client.post('/domain/zone/ffbsee.net/refresh')

# Pretty print
print "Refresh dns zone on ffbsee.net"
print json.dumps(result, indent=4)
