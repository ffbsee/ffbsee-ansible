#!/bin/bash
#  
#  Diese Datei wird von Ansible erstellt
#
#  Nicht oeffentliche IP's erstmal droppen
#  Koennte sonst aerger mit Providern geben...
#
/sbin/iptables -A FORWARD -d 192.168.0.0/16  -j REJECT --reject-with icmp-net-prohibited               # RFC 1918
/sbin/iptables -A FORWARD -d 172.16.0.0/12 -o {{ wan_base_interface }} -j REJECT --reject-with icmp-net-prohibited # RFC 1918
/sbin/iptables -A FORWARD -d 10.0.0.0/8 -o {{ wan_base_interface }} -j REJECT --reject-with icmp-net-prohibited    # RFC 1918
/sbin/iptables -A FORWARD -d 169.254.0.0/16  -j REJECT --reject-with icmp-net-prohibited               # APIPA - link-local
/sbin/iptables -A FORWARD -d 100.64.0.0/10  -j REJECT --reject-with icmp-net-prohibited                # ISP - carrier-grade NAT
/sbin/iptables -A FORWARD -d 224.0.0.0/3 -j REJECT --reject-with icmp-net-prohibited                   # multicast
/sbin/iptables -A FORWARD -d 192.0.0.0/24 -j REJECT --reject-with icmp-net-prohibited                  # IANA IPv4 Special Purpose Address Registry
/sbin/iptables -A FORWARD -d 192.0.2.0/24 -j REJECT --reject-with icmp-net-prohibited                  # TEST-NET-1
/sbin/iptables -A FORWARD -d 192.88.99.0/24 -j REJECT --reject-with icmp-net-prohibited                # 6to4 anycast relays (deprecated)
/sbin/iptables -A FORWARD -d 198.18.0.0/15 -j REJECT --reject-with icmp-net-prohibited                 # testing of inter-network communications
/sbin/iptables -A FORWARD -d 198.51.100.0/24 -j REJECT --reject-with icmp-net-prohibited               # TEST-NET-2
/sbin/iptables -A FORWARD -d 203.0.113.0/24 -j REJECT --reject-with icmp-net-prohibited                # TEST-NET-3
#
# NAT vom 'WAN' Interface zum 'B.A.T.M.A.N.' Interface
# 
/sbin/iptables -t nat -A POSTROUTING -o {{ wan_interface }} -j MASQUERADE
/sbin/iptables -A FORWARD -i {{ wan_interface }} -o {{ ipv4_dhcp_interface }} -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i {{ ipv4_dhcp_interface }} -o {{ wan_interface }} -j ACCEPT
{% if vpn_on_port_443 == 'true' %}#
# ICVPN Firewall Optionen
#
/sbin/iptables -A FORWARD -i {{ ipv4_dhcp_interface }} -o {{ icvpn_interface }} -j ACCEPT
/sbin/iptables -A FORWARD -i {{ icvpn_interface }} -o {{ ipv4_dhcp_interface }}-j ACCEPT
{% endif %}
