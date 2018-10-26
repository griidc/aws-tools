#!/usr/bin/python

import boto3
import sys
import json
import requests
import re

udi = sys.argv[1]
nudi = re.sub(':', '.', udi)
key = "Icebox/" + nudi + ".dat"
print("Key is " + key)

url = 'https://data.gulfresearchinitiative.org/api/datasets?udi=' + udi + '&_properties=datasetSubmission.datasetFileName,id'
pelagosFilename = json.loads(requests.get(url).text)[0]['datasetSubmission']['datasetFileName'] 

bucket = 'tamucc.griidc'
session = boto3.Session(profile_name='saml')
client = session.client('s3')
response = client.get_object_tagging(
    Bucket=bucket,
    Key=key,
)

newdata={}
newdata["Key"] = "OriginalPelagosFilename"
newdata["Value"] = pelagosFilename

# Count of number of tags on S3 Object in Bucket
numTags = len(response['TagSet'])
print('There were originally ' + str(numTags) + ' tags on ' + key)

originalTagsetDict={}
originalTagsetDict["TagSet"]=response["TagSet"]

flag=False
count=0

for thing1 in originalTagsetDict["TagSet"]:
    if thing1["Key"] == "OriginalPelagosFilename":
        flag=True
        break
    else:
        if flag == False and count == ( len(originalTagsetDict["TagSet"]) - 1):
            originalTagsetDict["TagSet"].append(newdata)
    count = count+1

response = client.put_object_tagging(
    Bucket=bucket,
    Key=key,
    Tagging=originalTagsetDict
)
