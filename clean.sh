#!/bin/bash
cd Packer \
&& AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2) \
&& cd .. \
&& kubectl delete -f smallcase.yml  \
&& cd Terraform \
&& yes yes | terraform destroy -var personal_ami=$AMI_ID