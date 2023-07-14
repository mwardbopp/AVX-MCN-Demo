variable "username" {
  default = "admin"
}

variable "password" {
}

variable "controller_ip" {
  default = "18.198.44.55"
}


variable "aws_account_name" {
  default = "AWS_Paul"
}



variable "mc_transit_region" {
  default = "eu-central-1"
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




variable "ha_enabled" {
  type    = bool
  default = false
}







# AWS SPOKES

variable "aws_spoke_instance_size" {
  default = "t3.micro"
}

variable "aws_spoke1_region" {
  default = "eu-central-1"
}

variable "aws_spoke1_name" {
  default = "ace-iac-spoke1"
}

variable "aws_spoke1_cidr" {
  default = "10.1.0.0/16"
}

variable "aws_spoke2_region" {
  default = "eu-central-1"
}

variable "aws_spoke2_name" {
  default = "ace-iac-spoke2"
}

variable "aws_spoke2_cidr" {
  default = "10.2.0.0/16"
}



# AZURE SPOKES

variable "az_spoke_instance_size" {
  default = "Standard_B1ms"
}

variable "az_spoke1_region" {
  default = "West Europe"
}

variable "az_spoke1_name" {
  default = "az-r1-spoke1"
}

variable "az_spoke1_cidr" {
  default = "10.110.0.0/16"
}

variable "az_spoke2_region" {
  default = "UK South"
}

variable "az_spoke2_name" {
  default = "az-r2-spoke1"
}

variable "az_spoke2_cidr" {
  default = "10.111.0.0/16"
}




# GCP SPOKES

variable "gcp_spoke_instance_size" {
  default = "n1-standard-1"
}

variable "gcp_spoke1_region" {
  default = "europe-west1"
}

variable "gcp_spoke1_name" {
  default = "gcp-spoke1"
}

variable "gcp_spoke1_cidr" {
  default = "10.120.0.0/16"
}

variable "gcp_spoke2_region" {
  default = "europe-west1"
}

variable "gcp_spoke2_name" {
  default = "gcp-spoke2"
}

variable "gcp_spoke2_cidr" {
  default = "10.121.0.0/16"
}




variable "aws_test_instance_size" {
  default = "t2.micro"
}

