# download and run this script
#   curl -o - https://raw.githubusercontent.com/nickhardiman/machine-host2/main/machine-workstation-configure.sh | bash -x

# SSH 
HOST=host2.lab.example.com
# set up password-less remote login
# if using the workstation CLI, not the host2 console or gnome desktop
# copy SSH public key from workstation to host2
USER=nick
ssh-copy-id $USER@$HOST

# test
# connect to the remote machine
ssh $USER@$HOST echo hello from $HOST	

