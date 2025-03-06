#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Starting Harness Ansible Delegate..."
/harness/start.sh &

# Ensure the /tmp/ansible-playbook directory is clean before cloning
if [ -d "/tmp/ansible-playbook" ]; then
    echo "Cleaning up existing repository..."
    rm -rf /tmp/ansible-playbook
fi

# Clone the Ansible playbook repository
echo "Cloning Ansible playbook repository..."
git clone https://github.com/your-repo/ansible-playbook.git /tmp/ansible-playbook
cd /tmp/ansible-playbook || { echo "Failed to enter the playbook directory"; exit 1; }

# Generate dynamic inventory
echo "Generating dynamic inventory..."
python3 /harness/dynamic_inventory.py > /etc/ansible/hosts

# Ensure Ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "Error: ansible-playbook command not found. Make sure Ansible is installed."
    exit 1
fi

# Run the Ansible playbook
echo "Running initial Ansible playbook..."
ansible-playbook /etc/ansible/playbooks/setup.yml

# Keep the container running
echo "Delegate setup complete. Keeping the container alive..."
tail -f /dev/null
