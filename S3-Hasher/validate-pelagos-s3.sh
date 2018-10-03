#!/bin/bash
file=$1

#Get expected hash from Pelagos
expectedHash=$(./query-pelagos-hash.py "$file")

# Set ACL to public for duration of the hash operation.
./set-permission.py "$file" "public"
# Calculate hash from S3
echo "Accessing via PUBLIC request"
calculatedHash=$(/usr/bin/aws s3 --no-sign-request --region=us-east-1 cp s3://tamucc.griidc/$file - | /usr/bin/sha256sum | sed "s/ .*$//")
# Set ACL back to private, which is the default for s3 objects.
./set-permission.py "$file" "private"


if [ "$expectedHash" == "$calculatedHash" ]; then
    echo "$1 PASSED Validation. Tagging for Glacier Storage."
    $(./tag-glacier.py "$file" "$calculatedHash") 
else
    echo "ERROR: $1 FAILED Validation.\rExpected ($expectedHash). Got: ($calculatedHash)."
fi
