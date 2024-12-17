useradd -m -d /home/ansible ansible -G wheel
echo 'ansible  ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/ansible
echo ansible | passwd --stdin ansible

cat > /home/ansible/ansible.cfg << EOL
[defaults]
inventory = /home/ansible/inventory
host_key_checking = false
remote_user = ansible
[privilege_escalation]
become = true
become_user = root
become_ask_pass = false
become_method = sudo
EOL

cat > /home/ansible/inventory << EOF
[default]
127.0.0.1 
EOF


echo 'ansible  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

cp -R ../OcpUtilityNodeSetup /home/ansible