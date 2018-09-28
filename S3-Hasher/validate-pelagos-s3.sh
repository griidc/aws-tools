#!/bin/bash
file=$1

#Get expected hash from Pelagos
expectedHash=$(./query-pelagos-hash.py "$file")

# Calculate hash from S3
calculatedHash=$(/usr/bin/aws --profile=saml s3 cp s3://tamucc.griidc/$file - | /usr/bin/sha256sum | sed "s/ .*$//")

if [ "$expectedHash" == "$calculatedHash" ]; then
    echo "$1 PASSED Validation. Tagging for Glacier Storage."
    $(./tag-glacier.py "$file" "$calculatedHash") 
else
    echo "ERROR: $1 FAILED Validation.\rExpected ($expectedHash). Got: ($calculatedHash)."
fi
