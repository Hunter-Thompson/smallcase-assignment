resource "aws_instance" "runner" {


  #Instance type
  instance_type = "t2.medium"

  #The AMI we created in Packer
  ami = var.personal_ami

  # The name of our SSH keypair we created above.
  key_name = aws_key_pair.auth.id

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]

  #Launch the instance in a private subnet
  subnet_id = module.vpc.private_subnets[0]

}