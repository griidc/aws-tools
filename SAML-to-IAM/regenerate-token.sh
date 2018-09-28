#!/bin/bash

# Generate New Token
/home/mwilliamson/aws-tools/SAML-to-IAM/samlapi_formauth_adfs3.py

# Install new token
cp /home/mwilliamson/.aws/credentials /home/users/mwilliamson/.aws/credentials

scp -i /home/mwilliamson/utilityvm.pem /home/mwilliamson/.aws/credentials ec2-user@ec2-34-229-16-206.compute-1.amazonaws.com:/home/ec2-user/.aws/
