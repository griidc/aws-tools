#!/bin/bash
# Preps VM build for Pelagos Hashing

# Add Pelagos aws-tool repo
cd ~
echo "yes" | git clone https://github.com/griidc/aws-tools.git

# Add boto3 as this is somehow failing in the userdata of the launch
# template. (workaround)
pip3 install boto3
