#resource "aws_key_pair" "vprofilekey" {
#  key_name   = "vprofilekey"
#  public_key = file(var.PUBLIC_KEY_PATH)
#}
#
#
#







resource "aws_key_pair" "ec2-bastion-host-key-pair" {
  depends_on = [local_file.ec2-bastion-host-public-key]
  key_name   = "vprofilekey"
  public_key = tls_private_key.ec2-bastion-host-key-pair.public_key_openssh
}
## Generate PEM (and OpenSSH) formatted private key.
resource "tls_private_key" "ec2-bastion-host-key-pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

## Create the file for Public Key
resource "local_file" "ec2-bastion-host-public-key" {
  depends_on = [tls_private_key.ec2-bastion-host-key-pair]
  content    = tls_private_key.ec2-bastion-host-key-pair.public_key_openssh
  filename   = "ec2-bastion-key-pair.pub"
}

## Create the sensitive file for Private Key
resource "local_sensitive_file" "ec2-bastion-host-private-key" {
  depends_on      = [tls_private_key.ec2-bastion-host-key-pair]
  content         = tls_private_key.ec2-bastion-host-key-pair.private_key_pem
  filename        = "ec2-bastion-key-pair.pem"
  file_permission = "0600"
}











#resource "aws_key_pair" "mytesst" {
#  depends_on = [local_file.ec2-bastion-host-public-key]
#  key_name   = "vprofilekey"
#  public_key = tls_private_key.ec2-bastion-host-key-pair.public_key_openssh
#}
### Generate PEM (and OpenSSH) formatted private key.
#resource "tls_private_key" "ec2-bastion-host-key-pair" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}
#
### Create the file for Public Key
#resource "local_file" "ec2-bastion-host-public-key" {
#  depends_on = [tls_private_key.ec2-bastion-host-key-pair]
#  content    = tls_private_key.ec2-bastion-host-key-pair.public_key_openssh
#  filename   = "ec2-bastion-key-pair.pub"
#}
#
### Create the sensitive file for Private Key
#resource "local_sensitive_file" "ec2-bastion-host-private-key" {
#  depends_on      = [tls_private_key.ec2-bastion-host-key-pair]
#  content         = tls_private_key.ec2-bastion-host-key-pair.private_key_pem
#  filename        = "ec2-bastion-key-pair.pem"
#  file_permission = "0600"
#}

