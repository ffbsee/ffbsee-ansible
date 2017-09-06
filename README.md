Ansible for Freifunk Bodensee node
==================================

This is the Ansible Repository for the Freifunk Community Freifunk Bodensee.
Here you can:
* deploy new Freifunk Gateways
* Deploy the same software on each gateway
* Manage admin users
* Update the infrastructure
* deplay old freifunk gateways too
* ...


Usage
-----

Run ansible with:

    ansible-playbook freifunk-setup.yml

from the top-level directory.


How 2 New admins
----------

To add a new person `NAME` with admin rights (root) on some device `FQDN`, do

* Add the file with your ssh key(s) at `files/admin_ssh_pubkeys/$nick_id.pub`
  * Make sure to use a unique `NAME`
  * Each key file must match the regex `NAME_id.pub`
* Edit the file `host_vars/FQDN` and add `NAME` on a new line
*Ansibele create a new user, where you can do `sudo su -l` to get root access.*

New Modules
---------
By executing the `freifunk-setup.yml` it should deploy each required peace of software on each freifunk gateway.
If you create new modules please add them at `freifunk-setup.yml`.
Don't forget to have a look in the [**Dokumentation**](http://docs.ansible.com/ansible/latest/list_of_all_modules.html). It may help you ;-)

