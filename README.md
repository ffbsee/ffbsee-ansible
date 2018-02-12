Ansible for Freifunk Bodensee Gateways
==================================

This is the Ansible Repository for the Freifunk Community Freifunk Bodensee.
Here you can:
* deploy *(new)* Freifunk Gateways *(or clone them)*
* Deploy the same software Version on each gateway
* Manage admin users
* Update the infrastructure
* ...

Clone Projekt
---
```
    # Clone the Git
    https://github.com/ffbsee/ansible.git

    # Clone the Submodules
    cd ansible
    git submodule update --init --recursive

```

Usage
-----

Run ansible with:

    ansible-playbook $GATEWAY.yml

from the **top-level directory**.


Freifunk Bodensee Network
=========================

There are some dedicated Servers, the Freifunk-Gateways:

* [gw01.ffbsee.net](https://gw01.ffbsee.net) - **Gateway #01**
  * Hetzner Server - Germany
  * Dual-Stack
  * AS24940
* [gw02.ffbsee.net](https://gw02.ffbsee.net) - **Gateway #02**
  * CCCZH Server - Swiss
  * In: IPv6, out: Dualstack
  * AS13030
* [gw03.ffbsee.net](https://gw03.ffbsee.net) - **Gateway #03**
  * MyLoc Server - Germany
  * Dualstack
  * AS24961
* [gw04.ffbsee.net](https://gw04.ffbsee.net) - **Gateway #04**
  * EST Server - Germany
  * Unknown
  * AS21263
* [sn01.ffbsee.net](https://sn01.ffbsee.de) - **Supernode #01**
  * VM - Swiss
  * Dual-Stack
  * AS559

## Functions
* Update Users
*Update the User privileges, SSH-Keys, and could add new Admins on all nodes*
````bash
ansible-playbook updateUsers.yml
````

 
