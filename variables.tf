variable "username" {
  default = "admin"
}

variable "password" {
}

variable "controller_ip" {
}


variable "aws_account_name" {
}

variable "mc_transit_region" {
  default = "us-east-2"
}

variable "mc_transit_name" {
  default = "avx-trns1"
}

variable "mc_transit_cidr" {
  default = "10.21.0.0/16"
}






variable "aws_transit_instance_size" {
  default = "t3.micro"
}


variable "aws_spoke_instance_size" {
  default = "t3.micro"
}

variable "aws_spoke1_region" {
  default = "us-east-2"
}

variable "aws_spoke1_name" {
  default = "ace-iac-spoke1"
}

variable "aws_spoke1_cidr" {
  default = "10.1.0.0/16"
}

variable "aws_spoke2_region" {
  default = "us-east-2"
}

variable "aws_spoke2_name" {
  default = "ace-iac-spoke2"
}

variable "aws_spoke2_cidr" {
  default = "10.2.0.0/16"
}
variable "aws_test_instance_size" {
  default = "t2.micro"
}


variable "ha_enabled" {
  type    = bool
  default = false
}