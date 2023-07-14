

# Transit Modules



module "framework" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"

  global_settings = {
    transit_accounts = {
      azure = "Azure_Paul_New",
      gcp   = "GCP_Paul",
      aws   = "AWS_Paul",
    }
  }

  transit_firenet = yamldecode(file("transit.yml"))
}