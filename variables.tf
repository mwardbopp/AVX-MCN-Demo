
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### GLOBAL VARIABLES
###
################################


variable "username" {
  default = "admin"
}

variable "password" {
}

variable "controller_ip" {
  default = "18.198.44.55"
}

################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### CSP ACCOUNTS
###
################################


variable "aws_account_name" {
  default = "AWS_Paul"
}

variable "az_account_name" {
  default = "Azure_Paul_New"
}

variable "gcp_account_name" {
  default = "GCP_Paul"
}



################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### GLOBAL SPOKE VARIABLES
###
################################




variable "ha_enabled" {
  type    = bool
  default = false
}


################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### AWS SPOKES
###
################################




variable "aws_spoke_instance_size" {
  default = "t3.micro"
}

variable "aws_spoke1_region" {
  default = "eu-central-1"
}

variable "aws_spoke1_name" {
  default = "aws-spoke1"
}

variable "aws_spoke1_cidr" {
  default = "10.101.0.0/16"
}

variable "aws_spoke2_region" {
  default = "eu-central-1"
}

variable "aws_spoke2_name" {
  default = "aws-spoke2"
}

variable "aws_spoke2_cidr" {
  default = "10.102.0.0/16"
}


################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### AZURE SPOKES
###
################################


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

################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### GCP SPOKES
###
################################




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


################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################



################################
###
### LEGACY STUFF
###
################################



variable "aws_test_instance_size" {
  default = "t2.micro"
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


# variable "admin_password" {
#   type = string
# }

# variable "app10_tags" {
#   description = "vm tags"
#   type        = map(string)
#   default     = null
# }

################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### AWS CSR VARIABLES
###
################################


variable "name" {
  description = "Custom name for VPC and sdwan headends"
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region to deploy this module in"
  type        = string
  default = "eu-central-1"
}

variable "cidr" {
  description = "The CIDR range to be used for the VPC"
  type        = string
  default     = "172.16.1.0/24"
}

variable "transit_gw_obj" {
  description = "Transit gateway object including attributes, to attach sdwan GW to"
}

variable "az1" {
  description = "Availability zone 1, for headend deployment"
  type        = string
  default     = "a"
}

variable "az2" {
  description = "Availability zone 2, for headend deployment"
  type        = string
  default     = "b"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = false
}

variable "vedge_image_version" {
  description = "Determines which image version will be deployed."
  type        = string
  default     = "20.3.1" #Make sure the version is available in the Marketplace
}

variable "csr_image_version" {
  description = "Determines which image version will be deployed."
  type        = string
  default     = "17.3.3" #Make sure the version is available in the Marketplace
}

variable "image_type" {
  description = "Determines whether CSR SDWAN (\"csr\") or vEdge (\"vedge\", default) image should be used."
  type        = string
  default     = "csr" #Use "csr" to select CSR image.
}

variable "instance_size" {
  description = "AWS Instance size for the SDWAN gateways"
  type        = string
  default     = "t2.medium"
}

variable "tunnel_cidr" {
  description = "CIDR to be used to create tunnel addresses"
  type        = string
  default     = "172.31.255.0/28"
}

variable "aviatrix_asn" {
  description = "ASN To be used on Aviatrix Transit Gateway for BGP"
  type        = string
  default     = "65302"
}

variable "sdwan_asn" {
  description = "ASN To be used on SDWAN Gateway for BGP"
  type        = string
  default     = "65501"
}

variable "aviatrix_tunnel_creation" {
  description = "When set to true, the IPSEC tunnels will be provisioned to the Aviatrix transit gateway."
  type        = bool
  default     = true
}

variable "use_existing_vpc" {
  description = "Set to true to use existing VPC."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID, for using an existing VPC."
  type        = string
  default     = ""
}

variable "sdwan_gw_subnet_cidr" {
  description = "Subnet CIDR, for using an existing VPC. Required when use_existing_vpc is true"
  type        = string
  default     = ""
}

variable "sdwan_ha_subnet_cidr" {
  description = "Subnet CIDR, for using an existing VPC. Required when use_existing_vpc is true and ha_gw is true"
  type        = string
  default     = ""
}

variable "sdwan_gw_subnet_id" {
  description = "Subnet ID, for using an existing VPC. Required when use_existing_vpc is true"
  type        = string
  default     = ""
}

variable "sdwan_ha_subnet_id" {
  description = "Subnet ID, for using an existing VPC. Required when use_existing_vpc is true and ha_gw is true"
  type        = string
  default     = ""
}

variable "second_interface" {
  description = "The additional interface on the SDWAN headend"
  type        = bool
  default     = false

}
locals {
  sdwan_gw_subnet_id   = var.use_existing_vpc ? var.sdwan_gw_subnet_id : aws_subnet.sdwan_1[0].id
  sdwan_ha_subnet_id   = var.use_existing_vpc ? var.sdwan_ha_subnet_id : aws_subnet.sdwan_2[0].id
  sdwan_gw_subnet_cidr = var.use_existing_vpc ? var.sdwan_gw_subnet_cidr : aws_subnet.sdwan_1[0].cidr_block
  sdwan_ha_subnet_cidr = var.use_existing_vpc ? var.sdwan_ha_subnet_cidr : aws_subnet.sdwan_2[0].cidr_block
  ami                  = length(regexall("vedge", lower(var.image_type))) > 0 ? data.aws_ami.vedge.id : data.aws_ami.csr.id
}