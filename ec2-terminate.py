import json
import boto3

ec2 = boto3.resource('ec2', region_name='us-east-1')

def lambda_handler(event, context):
    instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']},{'Name': 'tag:Name','Values':['goldenami-v2-goldenami-v2']}])
    for instance in instances:
        id=instance.id
        ec2.instances.filter(InstanceIds=[id]).terminate()
        print("Instance ID is terminated :- "+instance.id)
    return "success"
