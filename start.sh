#!/bin/bash
echo "Starting Harness Ansible Delegate..."
/harness/start.sh &

# Generate dynamic inventory
python3 /harness/dynamic_inventory.py > /etc/ansible/hosts

# Run an initial Ansible playbook (optional)
ansible-playbook /etc/ansible/playbooks/setup.yml

# Keep the container running
tail -f /dev/null
