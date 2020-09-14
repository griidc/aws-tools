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

echo "yes" | scp mwilliamson@poseidon.tamucc.edu:/home/users/mwilliamson/aws-secrets.tar.bz2 .
tar xfvj aws-secrets.tar.bz2

# Generated initial Token
#/home/ec2-user/aws-tools/SAML-to-IAM/samlapi_formauth_adfs3.py

# Cron re-generation of token every 4 hrs
#(crontab -l 2>/dev/null; echo "0 0,4,8,12,16,20 * * * /home/ec2-user/aws-tools/SAML-to-IAM/samlapi_formauth_adfs3.py") | crontab -


