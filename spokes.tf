



################################
###
### AWS SPOKES
###
################################


module "spoke_aws_1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.2"
  cloud           = "AWS"
  account         = var.aws_account_name
  region          = var.aws_spoke1_region
  name            = var.aws_spoke1_name
  cidr            = var.aws_spoke1_cidr
  instance_size   = var.aws_spoke_instance_size
  ha_gw           = var.ha_enabled
  # attached        = false  
  depends_on      = [module.framework.transit]
  transit_gw      = "mcn-aws-transit-r1"
}

module "spoke_aws_2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.2"

  cloud           = "AWS"
  account         = var.aws_account_name
  region          = var.aws_spoke2_region
  name            = var.aws_spoke2_name
  cidr            = var.aws_spoke2_cidr
  instance_size   = var.aws_spoke_instance_size
  ha_gw           = var.ha_enabled
  # attached        = false
  depends_on      = [module.framework.transit]
  transit_gw      = "mcn-aws-transit-r1"
}




################################
###
### AZURE SPOKES
###
################################


module "spoke_az_1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.2"

  cloud           = "AZURE"
  account         = var.az_account_name
  region          = var.az_spoke1_region
  name            = var.az_spoke1_name
  cidr            = var.az_spoke1_cidr
  instance_size   = var.az_spoke_instance_size
  ha_gw           = var.ha_enabled
  # attached        = false
  depends_on      = [module.framework.transit]
  transit_gw      = "mcn-az-transit-r1"
}

module "spoke_az_2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.2"

  cloud           = "AZURE"
  account         = var.az_account_name
  region          = var.az_spoke2_region
  name            = var.az_spoke2_name
  cidr            = var.az_spoke2_cidr
  instance_size   = var.az_spoke_instance_size
  ha_gw           = var.ha_enabled
  # attached        = false  
  depends_on      = [module.framework.transit]
  transit_gw      = "mcn-az-transit-r2"
}

# module "spoke_az_3" {
#   source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
#   version = "1.6.2"

#   cloud           = "AZURE"
#   account         = var.az_account_name
#   region          = var.az_spoke3_region
#   name            = var.az_spoke3_name
#   cidr            = var.az_spoke3_cidr
#   instance_size   = var.az_spoke_instance_size
#   ha_gw           = var.ha_enabled
#  
  # transit_gw      ="mcn-az-transit-r2
# }




################################
###
### GCP SPOKES
###
################################


module "spoke_gcp_1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.2"

  cloud           = "GCP"
  account         = var.gcp_account_name
  region          = var.gcp_spoke1_region
  name            = var.gcp_spoke1_name
  cidr            = var.gcp_spoke1_cidr
  instance_size   = var.gcp_spoke_instance_size
  ha_gw           = var.ha_enabled
  # attached        = false  
  depends_on      = [module.framework.transit]
  transit_gw      = "mcn-gcp-transit-r1"
}

module "spoke_gcp_2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.2"

  cloud           = "GCP"
  account         = var.gcp_account_name
  region          = var.gcp_spoke2_region
  name            = var.gcp_spoke2_name
  cidr            = var.gcp_spoke2_cidr
  instance_size   = var.gcp_spoke_instance_size
  ha_gw           = var.ha_enabled
  # attached        = false 
  depends_on      = [module.framework.transit]
  transit_gw      = "mcn-gcp-transit-r1"
}