terraform {
  required_version = ">= 1.0.2"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "paulaviatrix_iac"
    workspaces {
      name = "22020226_Lab"
    }
  }
}
