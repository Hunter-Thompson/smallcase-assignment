# SMALLCASE ASSIGNMENT

## Some information to take note of

- The default ssh public key Terraform uses to create the keypair on AWS is ~/.ssh/id_rsa.pub
- The default region Terraform and Packer creates the resources in is AP-SOUTH-1, MUMBAI.
- The deployment will fail the first time because we havent uploaded smallcase:latest yet to our AWS ECR repo. It will only run successfully after the CI completes its job.

## Dependencies

- Terraform

```sh
v0.13.0
```
- Packer

```sh
v1.6.1
```
- Kubectl 

- AWSCLI

```sh
aws-cli/2.0.34
```


## Requirements to fulfill before running `run.sh`

- Create Gitlab repo
- Add masked variables for the runner in CI/CD -> Variables. AWS_ACCESS_KEY, AWS_SECRET_KEY and IAM_ID. (PS: MAKE SURE TO LEAVE NO SPACES OR NEW LINES)
- Get the register token required to setup a runner from CI/CD -> Runner.
- Add that token in `Packer/gitlab.json` in the provisioners part.

```json      
{
        "type": "shell",
        "environment_vars": ["token=xccasdasdascascascasc"],
```

- Export your AWS credentials 

```sh
export AWS_ACCESS_KEY=
export AWS_SECRET_KEY=
```

- Replace $IAM_ID in the kube config smallcase.yml with your IAM_ID

```yml
      containers:
      - image: 1231823123.dkr.ecr.ap-south-1.amazonaws.com/smallcase:latest
        imagePullPolicy: Always
```


- Run `run.sh`.

```sh
./run.sh
```

- Finally upload all the files in the folder `devops-task` to the Gitlab Repo so that a CI/CD job can start and push the image to our Repo and fix the deployment.


## To clean up, run `clean.sh`
```sh
./clean.sh
```

### We can test automatic building and deployment by pushing changes to the application on the Gitlab Repo.


-----------

## What does `run.sh` do?

1) It first creates the ami for Gitlab CI.
2) It creates the Infra required.
3) It creates the kubernetes deployment
4) It outputs the loadbalancer DNS name.

## A small description on how it all works.

Packer creates the AMI for the Gitlab runner, the AMI has Docker, AWSCLI, Kubectl and Gitlab runner installed.

Terraform creates all the Infra in AWS, the Kubernetes cluster, VPC, Security groups, Subnets, Routes, etc.

The kubernetes config file creates a deployment with the app, and then exposes it as a service so that the ALB can connect to it. We create the ALB in AWS from the kubernetes config itself, this makes life a lot simpler. We can also use external DNS to route example.com to the ALB from the config if required.

For CI/CD, everytime we push code to master, the runner we created earlier gets notified of a job. It then runs all the commands listed in `devops-task/.gitlab-ci.yml`. Before every job we update the kubectl config to make sure that we have the right one, and also login to our AWS ECR repo.

3 jobs.

1) Create Repo in ECR if it doesnt exist, then build and tag the image.
2) Push the image to our Repo.
3) Tell the Kubernetes deployment we created earlier to start a rolling update with the new image we just built and pushed. The image tag will be the commit id of our latest commit.



# TODO 
- Add comments in the code.