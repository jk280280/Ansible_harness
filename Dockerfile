# Use Harness Delegate as the base image
FROM harness/delegate:latest  

# Set timezone environment variables to prevent tzdata from prompting
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install required tools
RUN apt update && \
    apt install -y ansible python3-pip awscli tzdata && \
    pip3 install boto3 && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /harness

# Copy necessary scripts and configurations
COPY entrypoint.sh /entrypoint.sh
COPY playbooks /etc/ansible/playbooks
COPY dynamic_inventory.py /harness/dynamic_inventory.py
COPY start.sh /harness/start.sh
COPY rollback.sh /harness/rollback.sh

# Provide execution permissions
RUN chmod +x /entrypoint.sh /harness/start.sh /harness/rollback.sh /harness/dynamic_inventory.py

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Default command to start the delegate
CMD ["/harness/start.sh"]
