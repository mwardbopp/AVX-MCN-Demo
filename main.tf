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
  transit_gw      = "mc_transit"
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
  transit_gw      = "mc_transit"
}

  

# AWS Transit Modules

module "mc_transit" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "v2.0.0"

  cloud                  = "AWS"
  cidr                   = var.mc_transit.cidr
  region                 = var.mc_transit.region
  account                = var.aws_account_name
  enable_transit_firenet = true
}

module "firenet_1" {
  source  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version = "1.0.0"

  transit_module = module.mc_transit
  firewall_image = "Palo Alto Networks VM-Series Next-Generation Firewall Bundle 1"
}

