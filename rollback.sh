#!/bin/bash
echo "Rolling back to the last stable version..."
ansible-playbook /etc/ansible/playbooks/rollback.yml
