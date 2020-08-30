# SMALLCASE ASSIGNMENT

## Some information to take note of

- The default ssh public key Terraform uses to create the keypair on AWS is ~/.ssh/id_rsa.pub
- The default region Terraform and Packer creates the resources in is AP-SOUTH-1, MUMBAI.
- The deployment will fail the first time because we havent uploaded smallcase:latest yet to our AWS ECR repo. It will only run successfully after the CI completes its job.

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


- Finally run `run.sh`.

```sh
./run.sh
```

## What does `run.sh` do?

1) It first creates the ami for Gitlab CI.
2) It creates the Infra required.
3) It creates the kubernetes deployment
4) It outputs the loadbalancer DNS name.


### We can test automatic building and deployment by pushing changes to the application on the Gitlab Repo.

# TODO 
- Add comments in the code.