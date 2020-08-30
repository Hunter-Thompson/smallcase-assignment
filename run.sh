#!/bin/bash

cd Packer \
&& packer build -var "aws_access_key=$AWS_ACCESS_KEY" -var "aws_secret_key=$AWS_SECRET_KEY" gitlab.json \
&& AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2) \
&& cd ../Terraform \
&& yes yes | terraform init \
&& yes yes | terraform apply -var personal_ami=$AMI_ID \ 
&& cd .. \
&& aws eks update-kubeconfig --name smallcase-dev --region ap-south-1 \
&& kubectl apply -f smallcase.yml \
&& echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" \
&& echo "sleeping for 30sec" \
&& sleep 30 \
&& kubectl get ingress 