#!/usr/bin/env python3
import boto3
import json

def get_ec2_instances():
    ec2 = boto3.client('ec2', region_name="us-west-1")
    instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    
    inventory = {"eks_nodes": {"hosts": []}}

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            ip_address = instance.get('PrivateIpAddress')
            if ip_address:
                inventory["eks_nodes"]["hosts"].append(ip_address)

    print(json.dumps(inventory, indent=2))

if __name__ == "__main__":
    get_ec2_instances()
