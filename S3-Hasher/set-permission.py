#!/usr/bin/python
import boto3
import sys

bucket = 'tamucc.griidc'
boto3.setup_default_session(profile_name='saml')

key = sys.argv[1]
change = sys.argv[2]

s3 = boto3.resource('s3')
object = s3.Bucket(bucket).Object(key)

if change.lower() == 'public':
    print("Setting PUBLIC access on: " + key)
    object.Acl().put(ACL='public-read')
elif change.lower() == 'private': 
    print("Setting PRIVATE access on: " + key)
    object.Acl().put(ACL='private')
else:
    print("Unknown request on: " + key + " taking no action.")
