#!/bin/bash

cd Packer \
&& packer build -var "aws_access_key=$AWS_ACCESS_KEY" -var "aws_secret_key=$AWS_SECRET_KEY" gitlab.json \
&& AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2) \
&& cd ../Terraform \
&& yes yes | terraform init \
&& yes yes | terraform apply -var personal_ami=$AMI_ID \ 
&& cd .. \
&& kubectl apply -f smallcase.yml \
&& echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
&& kubectl get ingress