FROM harness/delegate:latest

# Install dependencies
RUN apk update && apk add --no-cache \
    ansible \
    python3 \
    py3-pip \
    jq \
    aws-cli 

# Install Boto3 for AWS dynamic inventory
RUN pip3 install boto3

# Set work directory
WORKDIR /harness-delegate

# Copy the Harness Delegate entrypoint
COPY entrypoint.sh /entrypoint.sh

# Make entrypoint executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
