# download and run this script
#   curl -o - https://raw.githubusercontent.com/nickhardiman/machine-host2/main/machine-host2-configure.sh | bash -x

# SSH security
# if SSH service on this box is accessible to the Internet
# use key pairs only, disable password login
# for more information, see
#   man sshd_config
#echo "AuthenticationMethods publickey" >> /etc/ssh/sshd_config
 
# Prerequisites

# install Ansible and git
sudo dnf install --assumeyes ansible-core git

# install Ansible libvirt collection
sudo ansible-galaxy collection install community.libvirt --collections-path /usr/share/ansible/collections

# install my libvirt host role
mkdir -p ~/ansible/roles
cd ~/ansible/roles
git clone https://github.com/nickhardiman/libvirt-host.git
# smoke test
ansible-playbook --ask-become-pass libvirt-host/tests/test.yml

# host config
git clone https://github.com/nickhardiman/machine-host2.git
cd machine-host2
ansible-playbook --ask-become-pass machine-host2-configure.yml


