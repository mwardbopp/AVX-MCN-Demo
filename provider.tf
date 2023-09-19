provider "aviatrix" {
  controller_ip = var.controller_ip
  username      = var.username
  password      = var.password
}

provider "aws" {
  region = "eu-central-1"
  profile = "SubAccountAdmin-532699532838"
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
  subscription_id = "5d73d4c8-f386-43f2-a0ab-72a068e42740"
}

provider "google" {
  credentials = file("~/.ssh/mward-bopp-01-ce4d4412fb80.json")
  project     = "mward-bopp-01"
  region      = "europe-west1-b"
}