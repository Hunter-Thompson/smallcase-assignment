variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "name of keypair"
} 

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Example: ~/.ssh/id_rsa.pub
DESCRIPTION
}