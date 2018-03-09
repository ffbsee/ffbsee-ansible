#!/bin/bash
#
# Diese Datei wird von Ansible erstellt
#
# Auch beim IPv6 gibt es bischen zu tun
#
{% if wan_ipv6_ip: != "" %}

/sbin/ip6tables -A INPUT -i bat0 -p ipv6-icmp -m icmp6 --icmpv6-type 134 -j DROP
/sbin/ip6tables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/ip6tables -A FORWARD -m state --state NEW -m connlimit --connlimit-above 200 --connlimit-mask 128 --connlimit-saddr -j DROP
/sbin/ip6tables -A FORWARD -i bat0 -o {{ wan_interface }} -j ACCEPT
/sbin/ip6tables -t nat -A POSTROUTING -o {{ wan_interface }} -j NETMAP --to {{ wan_ipv6_network }}

{% endif %}
