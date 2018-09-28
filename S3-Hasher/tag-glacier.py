#!/usr/bin/python
import boto3
import sys

key = sys.argv[1]
sha256 = sys.argv[2]
bucket = 'tamucc.griidc'

session = boto3.Session(profile_name='saml')
client = session.client('s3')

response = client.put_object_tagging(
    Bucket=bucket,
    Key=key,
    Tagging={
        'TagSet': [
            {
                'Key': 'validated',
                'Value': '1'
            },
            {
                'Key': 'sha256',
                'Value': sha256
            },
            {
                'Key': 'archival_strategy',
                'Value': 'coldstorage'
            },
        ]
    }
)
