# Use the latest Harness delegate as the base image
FROM harness/delegate:latest  

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install Ansible, AWS CLI, and required Python packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends ansible python3-pip awscli && \
    pip3 install boto3 && \
    rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /harness

# Copy Ansible playbooks into the container
COPY playbooks /etc/ansible/playbooks

# Set correct permissions for playbooks directory
RUN chmod -R 755 /etc/ansible/playbooks

# Ensure start.sh exists and has execute permissions
COPY start.sh /harness/start.sh
RUN chmod +x /harness/start.sh

# Default command to run the delegate
CMD ["./start.sh"]
