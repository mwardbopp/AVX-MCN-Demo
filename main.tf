# AWS Spoke Modules

module "spoke_aws_1" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.0"
  cloud           = "AWS"
  account         = var.aws_account_name
  region          = var.aws_spoke1_region
  name            = var.aws_spoke1_name
  cidr            = var.aws_spoke1_cidr
  instance_size   = var.aws_spoke_instance_size
  ha_gw           = var.ha_enabled
  transit_gw      = "avx-trns1"
}

module "spoke_aws_2" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.1.0"

  cloud           = "AWS"
  account         = var.aws_account_name
  region          = var.aws_spoke2_region
  name            = var.aws_spoke2_name
  cidr            = var.aws_spoke2_cidr
  instance_size   = var.aws_spoke_instance_size
  ha_gw           = var.ha_enabled
  transit_gw      = "avx-trns1"
}

  

# AWS Transit Modules

module "mc_transit" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "v1.1.1"

  cloud                  = "aws"
  cidr                   = var.mc_transit_cidr
  region                 = var.mc_transit_region
  account                = var.aws_account_name
  enable_transit_firenet = true
}

