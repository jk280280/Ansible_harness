#!/usr/bin/env python3
import boto3
import json

AWS_REGION = "us-east-1"

ec2 = boto3.client("ec2", region_name=AWS_REGION)

instances = ec2.describe_instances(Filters=[
    {"Name": "tag:eks:nodegroup-name", "Values": ["*"]},
    {"Name": "instance-state-name", "Values": ["running"]}
])

inventory = {"eks_nodes": {"hosts": []}}

for reservation in instances["Reservations"]:
    for instance in reservation["Instances"]:
        inventory["eks_nodes"]["hosts"].append(instance["PrivateIpAddress"])

print(json.dumps(inventory, indent=2))
