# OpenShift Container Platform Utility Node Setup with Ansible
===========================================================

This repository contains an Ansible role, `OcpUtility`, designed to automate the setup of utility nodes on an OpenShift Container Platform (OCP) cluster.

**Overview**
------------

The `OcpUtility` role streamlines the process of configuring and deploying utility nodes on an OCP cluster. Utility nodes are used for various tasks such as dhcp server, named server and haproxy. This role simplifies the setup process, ensuring consistency and reducing manual effort.


Requirements
------------

- Ansible 2.9 or later
- A Linux system with NetworkManager installed
- User ansible create and have sudo privilege


**Role Variables**
=====================

The following variables are used to configure the OpenShift Container Platform utility playbook.

### Utility Node

* `hostname`: The hostname of the utility node (e.g. `utility.example.com`)
* `domain_name`: The domain name of the utility node (e.g. `example.com`)
* `dhcpd_server_ip`: The IP address of the DHCP server (e.g. `10.10.0.90`)
* `dhcpd_range_start` and `dhcpd_range_end`: The start and end IP addresses of the DHCP range (e.g. `10.10.0.100` and `10.10.0.120`)
* `network_ip`: The IP address and subnet mask of the network (e.g. `10.10.0.0/24`)
* `reverse_value`: The last octet of the IP address used to create the reverse zone file (e.g. `90`)

### Bootstrap Node

* `bootstrap_ip`: The IP address of the bootstrap node (e.g. `10.10.0.100`)
* `bootstrap_hostname`: The hostname of the bootstrap node (e.g. `bootstrap.example.com`)
* `bootstrap_name`: The name of the bootstrap node (e.g. `bootstrap`)

### Cluster Details

* `cluster_name`: The name of the OpenShift Container Platform cluster (e.g. `ocp4`)
* `cluster_network`: The network CIDR of the cluster (e.g. `237.84.2.178/14`)

### Control Plane Nodes

* `control_plane`: A list of control plane nodes, each with:
	+ `name`: The name of the control plane node (e.g. `master1`)
	+ `ip`: The IP address of the control plane node (e.g. `10.10.0.101`)
	+ `mac`: The MAC address of the control plane node (optional)
	+ `etcd`: The etcd port number of the control plane node (e.g. `101`)
	+ `srv`: The SRV record for the control plane node (e.g. `_etcd-server-ssl._tcp`)

### Worker Nodes

* `worker`: A list of worker nodes, each with:
	+ `name`: The name of the worker node (e.g. `worker1`)
	+ `ip`: The IP address of the worker node (e.g. `10.10.0.104`)
	+ `mac`: The MAC address of the worker node (optional)
	+ `etcd`: The etcd port number of the worker node (e.g. `104`)

### Network Interfaces

* `external_interface`: A list of external network interfaces, each with:
	+ `name`: The name of the external interface (e.g. `ens18`)
	+ `ip`: The IP address of the external interface (e.g. `192.168.0.7`)
	+ `gateway`: The gateway IP address of the external interface (e.g. `192.168.0.3`)
* `internal_interface`: A list of internal network interfaces, each with:
	+ `name`: The name of the internal interface (e.g. `ens19`)
	+ `ip`: The IP address of the internal interface (e.g. `10.10.0.90`)
	+ `gateway`: The gateway IP address of the internal interface (e.g. `10.10.0.1`)

### Registry Data

* `nfs_directory`: The directory path where registry data is stored (e.g. `/share/registry`)

### HTTPD Server

* `httpd_port`: The port number used to access the HTTPD server (e.g. `8080`)

**Dependencies**
================

This playbook requires the following dependencies:

* `ansible-galaxy collection install ansible.posix`

**Setup**
=====

To set up the Ansible environment, run the following script:

```bash
./pre-requis.sh
```

This script will create an Ansible user with a password and generate an SSH key pair.

**Note**: Make sure to update the `hosts` file with the IP addresses of your nodes before running the playbook.


**Usage**
---------

1. Clone this repository and navigate to the `roles/OcpUtility` directory.
2. Update the `vars/main.yml` file with your OCP cluster details and desired configuration.
3. Run the example playbook using `ansible-playbook -i hosts playbook.yml`.

**Troubleshooting**
------------------

For issues or errors, refer to the Ansible official documentation and the OCP cluster logs for more information.

**Contributing**
--------------

Contributions are welcome! Please submit pull requests or issues to this repository.

I hope this helps! Let me know if you have any further questions or if there's anything else I can help with.

License
-------

BSD

Author Information
------------------

Florient
