#data "aws_ami" "ubuntu" {
#  owners      = ["amazon"]
#  most_recent = true
#  name_regex  = "ubuntu"
#}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical (responsável pela distribuição do Ubuntu)
  most_recent = true
  name_regex  = "^ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
}
