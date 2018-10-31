#!/usr/bin/python

import requests
import sys
import json
import re

# example: GET https://data.gulfresearchinitiative.org/pelagos-symfony/api/datasets?udi=R1.x132.139:0010&_properties=datasetSubmission.datasetFileSha256Hash,udi

udi = sys.argv[1]

# Convert S3 filenames to Pelagos UDI (Sidenote: The colon ':' not supported by S3.)
udi = re.sub('^.*\/', '', udi)
udi = re.sub('.dat$', '', udi)
udi = re.sub(
    pattern=r'(\.)([0-9]{4})',
    repl=':\\2',
    string=udi
)

url = 'https://data.gulfresearchinitiative.org/pelagos-symfony/api/datasets?udi=' + udi + '&_properties=datasetSubmission.datasetFileSha256Hash,udi'
sha256 = json.loads(requests.get(url).text)[0]['datasetSubmission']['datasetFileSha256Hash']

print(sha256)
