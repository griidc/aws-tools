#!/usr/bin/python

# This will eventually have to be turned into a consumer
# that generates a Pelagos AWS download URL for a single use. 

import boto3
import requests

# Get the service client.
session = boto3.Session(profile_name='saml')
s3 = session.client('s3')

# Generate the URL to get 'key-name' from 'bucket-name'
url = s3.generate_presigned_url(
    ClientMethod='get_object',
    Params={
        'Bucket': 'tamucc.griidc',
        'Key': 'Active/mwilliamson.jpg'
    },
    ExpiresIn=60
)

print(url)

