# AWS Spoke Modules
module "spoke_aws_1" {
  source  = "terraform-aviatrix-modules/aws-spoke/aviatrix"
  version = "4.0.3"

  account         = var.aws_account_name
  region          = var.aws_spoke1_region
  name            = var.aws_spoke1_name
  cidr            = var.aws_spoke1_cidr
  instance_size   = var.aws_spoke_instance_size
  ha_gw           = var.ha_enabled
  prefix          = false
  suffix          = false
  transit_gw      = module.aws_transit_1.transit_gateway.gw_name
}

module "spoke_aws_1" {
  source  = "terraform-aviatrix-modules/aws-spoke/aviatrix"
  version = "4.0.3"

  account         = var.aws_account_name
  region          = var.aws_spoke2_region
  name            = var.aws_spoke2_name
  cidr            = var.aws_spoke2_cidr
  instance_size   = var.aws_spoke_instance_size
  ha_gw           = var.ha_enabled
  prefix          = false
  suffix          = false
  transit_gw      = module.aws_transit_1.transit_gateway.gw_name
}

# AWS Transit Modules

module "transit_aws_1" {
  source  = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version = "v4.0.3"

  account             = var.aws_account_name
  region              = var.aws_transit1_region
  name                = var.aws_transit1_name
  cidr                = var.aws_transit1_cidr
  ha_gw               = var.ha_enabled
  prefix              = false
  instance_size       = var.aws_transit_instance_size
}


