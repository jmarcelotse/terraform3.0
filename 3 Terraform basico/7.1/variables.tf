variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-2"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "default"
}

variable "environment" {
  type        = string
  description = ""
  default     = "dev"
}

variable "instance_ami" {
  type        = string
  description = ""
  default     = "ami-033fabdd332044f06"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t3.micro"
}

variable "instance_tags" {
  type        = map(string)
  description = ""
  default = {
    OS      = "Ubuntu"
    Project = "Terraform 3.0"
  }
}
