![Freifunk Bodensee](https://freifunk-bodensee.net/images/see.svg "FFBSee")

 Freifunk Ansible
=======

Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs. Ansible works by connecting to your nodes and pushing out small programs, called "Ansible modules" to them. These programs are written to be resource models of the desired state of the system. Ansible then executes these modules (over SSH by default), and removes them when finished.
[Learn more](https://www.ansible.com/overview/how-ansible-works)

This `git` repository contains the Ansible code and data to configure and deploy the Freifunk Bodensee gateway server.

 How to Clone the Projekt
------------------------

```bash
# Clone the Git
git clone https://github.com/ffbsee/ansible.git ffbsee-anisble

# Clone the Submodules too
cd ffbsee-ansible
git submodule update --init --recursive
```

 General Information:
-------------------------
We use ansible to deploy all gateways on the Freifunk Bodensee Network. <br/>
First we did this only sometimes at some of the time. And we always had the issue, tat there probably are non-commited changes on each gateway and running ansible would crash everything.

With this ansible playbook collection and the change to ``B.A.T.M.A.N. V`` we will improve this with a 100% coverage of ansible. Let's see, if this will work.

**REMEBER:**

**DON'T CHANGE ANYTHING LOCAL ON THE GATEWAYS. USE ANSIBLE AND COMMIT AND PUSH YOUR CHANGES!!!**

Usage
-----

There is an Ansible playbook for each Gateway that runs wit ``B.A.T.M.A.N. V``. To deploy the latest changes or the whole setup on any gateway simply execute on your own machine:

```
ansible-playbook $GATEWAY.yml
```

from the **top-level directory** of this `git` repository.


Freifunk Bodensee Network
=========================

Right now, there are some dedicated servers, the Freifunk-Gateways:

* [gw01.ffbsee.net](https://gw01.ffbsee.net:444) - **Gateway 01**
  * Hetzner Server
  * Germany
  * Dual-Stack
  * AS 24940
<!--
* [gw02.ffbsee.net](https://gw02.ffbsee.net) - **Gateway 02**
  * CCCZH Server
  * Swiss
  * fastd: Dual-Stack; web, ssh etc: IPv6
  * AS 13030
* [gw03.ffbsee.net](https://gw03.ffbsee.net) - **Gateway 03**
  * MyLoc Server
  * Germany
  * Dual-Stack
  * AS 24961
* [gw04.ffbsee.net](https://gw04.ffbsee.net) - **Gateway 04**
  * Lake Constance Area
  * Germany
  * IPv4 only
  * AS 21263
-->

 Adresses:
-----------
Please visit [ICVPN META](https://github.com/freifunk/icvpn-meta/blob/master/bodensee)
```bash
  fdef:1702:b5ee::/48
  10.11.160.0/20
  10.15.224.0/20 
```

 Add another gateway
---------------------

To add an other gateway please read the [Instructions](https://github.com/ffbsee/ansible/blob/master/NEWGATEWAY.md) and talk to us via [#ffbsee](https://webirc.hackint.org/#irc://irc.hackint.org/#ffbsee) or mailing list!


 Tipps
=====

If you need a jump host to reach a gateway simply use this command:
```bash
ansible-playbook --ssh-common-args="-o ProxyCommand='ssh -W [%h]:%p ansible@gw03.ffbsee.net'" gw02.ffbsee.yml
```

Only run the roles with the "update" tag and not the full playbook:
```bash
ansible-playbook update_admins.yml --tags "update"
```


