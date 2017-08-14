---

admins:
  - raoul
  - l3d

ipv6_suffix: ':1:2'
ipv4_mesh_address: '10.11.160.102'
hostname: 'gw02.ffbsee.de'
wan_interface: 'enp1s0f0.240'

ipv6_address: '{{ ipv6_prefix }}{{ ipv6_suffix }}' 
