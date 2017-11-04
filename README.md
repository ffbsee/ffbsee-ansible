Ansible for Freifunk Bodensee Gateways
==================================

This is the Ansible Repository for the Freifunk Community Freifunk Bodensee.
Here you can:
* deploy *(new)* Freifunk Gateways *(or clone them)*
* Deploy the same software Version on each gateway
* Manage admin users
* Update the infrastructure
* ...


Usage
-----

Run ansible with:

    ansible-playbook freifunk-setup.yml

from the **top-level directory**.


Freifunk Bodensee Network
=========================

There are some dedicated Servers, the Freifunk-Gateways:

* [gw01.ffbsee.de](https://vpn8.ffbsee.de) - Gateway #01
 * Hetzner Server - Germany
 * Dual-Stack
 * Thanks to FF3L and kpanic
* [gw02.ffbsee.de](https://gw02.ffbsee.de) - Gateway #02
 * CCCZH Server - Swiss
 * In: IPv6, out: Dualstack
 * Thanks to CCCZH and raoul
* [n01.ffbsee.de](https://vpn9.ffbsee.de) - Node #01
 * VM - Swiss
 * Dual-Stack
 * Thanks to bostan

## Functions
* Update Users
*Update the User privileges, SSH-Keys, and could add new Admins on all nodes*
````bash
ansible-playbook updateUsers.yml
````

 
