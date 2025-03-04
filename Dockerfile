FROM harness/delegate:latest  # Use latest Harness delegate as base

# Install Ansible and AWS CLI
RUN apt update && apt install -y ansible python3-pip awscli \
    && pip3 install boto3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /harness

# Copy Playbooks
COPY playbooks /etc/ansible/playbooks

# Default command
CMD ["./start.sh"]
