#!/bin/bash
#Get key (S3 file) from CLI 1st arg
file=$1

#Get expected hash from CLI 2nd arg
expectedHash=$2

# Calculate hash from S3
echo "Accessing via S3 cp request"
calculatedHash=$(/usr/bin/aws s3 --profile=s3-util --region=us-east-1 cp s3://tamucc.griidc/$file - | /usr/bin/sha256sum | sed "s/ .*$//")

if [ "$expectedHash" == "$calculatedHash" ]; then
    echo "$1 PASSED Validation. Tagging for Glacier Storage."
    $(./tag-glacier.py "$file" "$calculatedHash")
    # shut down the instance (can be configured to auto-terminate on launch panel)
    sleep 60
    sudo /sbin/shutdown -h now
else
    # Instance stays running and displays this error if hash does not succeed.
    echo "ERROR: $1 FAILED Validation.\rExpected ($expectedHash). Got: ($calculatedHash)."
fi
