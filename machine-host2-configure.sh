
# SSH security
# if SSH service on this box is accessible to the Internet
# use key pairs only, disable password login
# for more information, see
#   man sshd_config
#echo "AuthenticationMethods publickey" >> /etc/ssh/sshd_config
 
# Prerequisites

# install Ansible and git
sudo dnf install ansible-core git

# install Ansible libvirt collection
sudo ansible-galaxy collection install community.libvirt --collections-path /usr/share/ansible/collections/ansible_collections

# install my libvirt host role
mkdir -p ~/ansible/roles
cd ~/ansible/roles
git clone https://github.com/nickhardiman/libvirt-host.git
# smoke test
sudo ansible-playbook libvirt-host/tests/test.yml

# host config
git clone https://github.com/nickhardiman/machine-host2.git
cd machine-host2
sudo ansible-playbook machine-host2-configure.yml


