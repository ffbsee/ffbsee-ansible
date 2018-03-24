![Freifunk Bodensee](https://freifunk-bodensee.net/lib/tpl/dokuwiki-template/images/logo.svg "FFBSee")

 Ansible
==========

Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.
Ansible works by connecting to your nodes and pushing out small programs, called "Ansible modules" to them. These programs are written to be resource models of the desired state of the system. Ansible then executes these modules (over SSH by default), and removes them when finished.
[Learn more](https://www.ansible.com/overview/how-ansible-works)

 How to Clone the Projekt
---
```
# Clone the Git
https://github.com/ffbsee/ansible.git

# Clone the Submodules too
cd ansible
git submodule update --init --recursive

```

 Usage
---

There is an Ansible-Playbook for each Gateway. To deplay the latest changes on an gateway or the whole setup sinply execute on your own machine:

ansible-playbook $GATEWAY.yml

from the **top-level directory** of this git repository.


 Freifunk Bodensee Network
=========================

Right now there are some dedicated Servers, the Freifunk-Gateways:

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
  * Lake Constance Area, Germany
  * IPv4 only
  * AS21263

 Add another gateway:
---
To Add an other Gateway pleas read the [Instructions](https://github.com/ffbsee/ansible/blob/master/NEWGATEWAY.md) an Talk to us via IRC or Mailing List!

 Tipps:
---
If you nee a Jump-Host to reach an gateway simply use this command argues:
```bash
ansible-playbook --ssh-common-args="-o ProxyCommand='ssh -W [%h]:%p ansible@gw03.ffbsee.net'" gw02.ffbsee.yml
```
