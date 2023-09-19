

# Transit Modules



module "framework" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"

  global_settings = {
    transit_accounts = {
      azure = var.az_account_name,
      gcp   = var.gcp_account_name,
      aws   = var.aws_account_name,
    }
  }

    # transit_firenet = yamldecode(file("transit.yml"))
    transit_firenet = {
  transit1 = {
    transit_name        = "mcn-aws-transit-r1"
    transit_ha_gw       = false
    transit_asn         = 65301
    transit_cidr        = "10.1.0.0/23"
    transit_cloud       = "aws"
    transit_region_name = "eu-central-1"
  },

  transit2 = {
    transit_name        = "mcn-az-transit-r1"
    transit_ha_gw       = false
    transit_asn         = 65302
    transit_cidr        = "10.1.2.0/23"
    transit_cloud       = "azure"
    transit_region_name = "West Europe"
  },

  transit3 = {
    transit_name        = "mcn-az-transit-r2"
    transit_ha_gw       = false
    transit_asn         = 65303
    transit_cidr        = "10.1.4.0/23"
    transit_cloud       = "azure"
    transit_region_name = "UK South"
  },

  transit4 = {
    transit_name        = "mcn-gcp-transit-r1"
    transit_ha_gw       = false
    transit_asn         = 65304
    transit_cidr        = "10.1.6.0/23"
    transit_cloud       = "gcp"
    transit_region_name = "europe-west1"
  }
}

}