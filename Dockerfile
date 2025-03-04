# Use Harness Delegate as the base image
FROM harness/delegate:latest  

# Install required tools (Ansible, AWS CLI, Python dependencies)
RUN apt update && apt install -y ansible python3-pip awscli \
    && pip3 install boto3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /harness

# Copy Playbooks and Scripts
COPY playbooks /etc/ansible/playbooks
COPY start.sh /harness/start.sh
COPY rollback.sh /harness/rollback.sh

# Provide execution permissions
RUN chmod +x /harness/start.sh /harness/rollback.sh

# Default command to start delegate
CMD ["./start.sh"]
