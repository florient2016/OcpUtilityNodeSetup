#!/bin/bash

# Add user ansible to the wheel group
useradd -m -d /home/ansible ansible -G wheel

# Give ansible user full sudo access without password prompt
echo 'ansible  ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/ansible

# Set the password for the ansible user to "ansible"
echo ansible | passwd --stdin ansible

# Create a configuration file for Ansible
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

# Create an inventory file with the default host
cat > /home/ansible/inventory << EOF
[default]
127.0.0.1 
EOF

# Add the ansible user to the sudoers file with full access
echo 'ansible  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

# Generate a list of random MAC addresses
number_node=5
for i in $(seq 1 $number_node); do 
    # Print a random MAC address in the format "52:54:00:xx:xx:xx"
    printf '52:54:00:%02x:%02x:%02x\n' $((RANDOM%256)) $((RANDOM%256)) $i
done > mac_addresses.txt

# Print the generated list of MAC addresses
cat mac_addresses.txt


# Input files
mac_file="mac_addresses.txt"
dhcp_file="./OcpUtilityNodeSetup/OcpUtility/vars/main.yml"
output_file="vars_updated.txt"

# Check if both files exist
if [[ ! -f $mac_file || ! -f $dhcp_file ]]; then
  echo "Error: mac_addresses.txt or dhcp.txt not found!"
  exit 1
fi

# Read MAC addresses into an array
readarray -t mac_array < "$mac_file"

# Replace mac1, mac2, ... with corresponding MAC addresses
awk -v mac_addresses="${mac_array[*]}" '
BEGIN {
    split(mac_addresses, macs, " ");
}
{
    line = $0;
    for (i = 0; i < length(macs); i++) {
        placeholder = "mac" i;
        sub(placeholder, macs[i+1], line);
    }
    print line;
}' "$dhcp_file" > "$output_file"

# Replace the original file with the updated one
mv "$output_file" "$dhcp_file"

echo "Placeholders have been replaced successfully in $dhcp_file."

echo "UPDATE OcpUtilityNodeSetup/OcpUtility/vars/main.yml FILE ACCORDING TO YOUR NETWORK DETAILS"
