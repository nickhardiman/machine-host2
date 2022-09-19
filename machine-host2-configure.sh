# run
# log into host2
# download and run this script
#   curl -o - https://raw.githubusercontent.com/nickhardiman/machine-host2/main/machine-host2-configure.sh | bash -x

# SSH security
# if SSH service on this box is accessible to the Internet
# use key pairs only, disable password login
# for more information, see
#   man sshd_config
#echo "AuthenticationMethods publickey" >> /etc/ssh/sshd_config
 
# install Ansible
sudo dnf install --assumeyes ansible-core
# install Ansible libvirt collection
sudo ansible-galaxy collection install community.libvirt --collections-path /usr/share/ansible/collections

# install git
sudo dnf install --assumeyes git
git config --global user.name         "Nick Hardiman"
git config --global user.email        nick@email-domain.com
git config --global github.user       nick
git config --global push.default      simple
# default timeout is 900 seconds (https://git-scm.com/docs/git-credential-cache)
git config --global credential.helper 'cache --timeout=1200'


# install my libvirt host role
# I'm not using ansible-galaxy because I am actively developing this role.
# Check out the directive in ansible.cfg in some playbooks.
mkdir -p ~/ansible/roles
cd ~/ansible/roles
# If the repo has already been cloned, git exits with this error message. 
#   fatal: destination path 'libvirt-host' already exists and is not an empty directory.
git clone https://github.com/nickhardiman/libvirt-host.git
# turn the host into a hypervisor
sudo ansible-playbook libvirt-host/tests/test.yml

# host config
mkdir -p ~/ansible/playbooks
cd ~/ansible/playbooks
git clone https://github.com/nickhardiman/machine-host2.git
cd machine-host2
ansible-playbook --ask-become-pass machine-host2-configure.yml

# guest: builder1
# get the code
cd ~/ansible/playbooks
git clone https://github.com/nickhardiman/vm-builder1
cd vm-builder1
# install roles to ~/.ansible/roles/
ansible-galaxy install -r roles/requirements.yml
# build the machine
ansible-playbook \
  --ask-become-pass  \
  -e 'rhsm_user=RH_user'  \
  -e 'rhsm_password=RH_password' \
  -e 'rhsm_pool_id=12345'  \
  main.yml
# test
