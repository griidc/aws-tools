#!/bin/bash
# Preps VM build for Pelagos Hashing

# This is now in the AWS launch template,
# but left here for reference only.
#yum update -y
#yum install htop automake gcc-c++ ncurses-devel git -y
#pip install --upgrade beautifulsoup4 lxml awscli boto boto3 ntlm-auth requests-ntlm requests bs4 sts
#sudo reboot

# This is to be run as the ec2-user, via
# an ssh connection from an account with
# access to the aws secrets file and agent
# forwarding is place for authentication to
# that account.

echo "yes" | scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null mwilliamson.admin@griidc-prod.tamucc.edu:/home/mwilliamson.admin/aws-secrets.tar.bz2 .
tar xfvj aws-secrets.tar.bz2
