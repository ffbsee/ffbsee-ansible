Ansible for Freifunk Bodensee node
==================================

This is the Ansible Repository for the Freifunk Community Freifunk Bodensee.
Here you can deploy new Freifunk Gateways..


Usage
-----

Run ansible with:

    ansible-playbook freifunk-setup.yml

from the top-level directory.


New admins
----------

To add a new person `NAME` with admin rights (root) on some device `FQDN`, do

* Add one or more ssh keys to `files/admin_ssh_pubkeys/$nick_id.pub`
  * Make sure to use a unique `NAME`
  * Each key file must match the regex `NAME_id.pub`
* Edit the file `host_vars/FQDN` and add `NAME` on a new line


