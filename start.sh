#!/bin/bash

echo "Starting Harness Delegate with Ansible..."
service ssh start

# Run Ansible to configure EKS nodes
ansible-playbook /etc/ansible/playbooks/setup.yml

# Start Harness Delegate
exec /harness/start.sh
