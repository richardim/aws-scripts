import boto3

# Enter the region your instances are in, e.g. 'us-east-1'
region = 'us-east-1'

# Enter your instances here: ex. ['X-XXXXXXXX', 'X-XXXXXXXX']
instances = [
    'i-0f1070bdedd3a18e4',
    'i-0e9606e16d0f0bc1b',
    'i-02e6122aafcbb83f1',
    'i-0884545107768d4ae',
    'i-0fad424c94a731be8',
    'i-0146d5ae5ea5c0989',
    'i-0f737e18c61676252',
    'i-0341cd51af74a0132',
    'i-0ed65d185076761ce',
    'i-0657f0e33853cdbdf',
    'i-03b1b601cfca86deb',
    'i-084e2c3a537d41cc1'
]

def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    ec2.stop_instances(InstanceIds=instances)
    print 'stopped your instances: ' + str(instances)
