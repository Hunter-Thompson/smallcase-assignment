# SMALLCASE ASSIGNMENT

## First we create the Kubernetes cluster.

```sh
cd Terraform && terraform init && yes yes | terraform apply
```

With this we created a VPC with a private and public subnet for each availibity zone, public and private routes to route outside or inside, an internet gateway and a NAT gateway. Also a security group which gives remote SSH access to our worker nodes from within the VPC.

## Second we create our Kubernetes deployment.

```sh
kubectl apply -f smallcase.yml
```

## Third and last we upload the files from the folder devops-task to the Gitlab Repo which is allowed to run CI/CD jobs.

### We can test automatic building and deployment by pushing changes to the application on the Gitlab Repo.