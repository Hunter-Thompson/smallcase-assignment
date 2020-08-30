variable "region" {
  default = "ap-south-1"
}

variable "key_name" {
  description = "name of keypair"
  default     = "key-terraform"
} 

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Example: ~/.ssh/id_rsa.pub
DESCRIPTION
  default = "~/.ssh/id_rsa.pub"
}

variable "personal_ami" {
  description = "AMI we created using Packer"
}