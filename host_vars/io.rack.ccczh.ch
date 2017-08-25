---

admins:
  - raoul
  - l3d

hostname: 'gw02.ffbsee.de'

ipv4_mesh_address: '10.11.160.102'

ipv6_suffix: ':1:2'
ipv6_address: '{{ ipv6_prefix }}{{ ipv6_suffix }}'

wan_base_interface: 'enp1s0f0'
wan_vlan_id: '240'
wan_interface: '{{ wan_base_interface }}.{{ wan_vlan_id }}' # TODO: Fix case of empty vlan id

fastd_secret_key: ''

fastd_vpn_backbone_configs:
  - vpn1
  - vpn2
  - vpn3
  - vpn4
  - vpn5
  - vpn6
  - vpn7
  - vpn8
