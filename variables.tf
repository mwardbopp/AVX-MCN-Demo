
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
  default = "terraform"
}

variable "password" {
}

variable "controller_ip" {
  default = "controller.wardbopp.com"
}

variable "aws_linux_ami_search_name" {
  
}

################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


# Gatus variable  


variable "aws_non_prod_eng_ip" {
  description = "Private IP address for the EC2 instance in the non-production environment."
  type        = string
  default     = "10.101.0.41" # Replace with your desired default value
}

variable "az_non_prod_ip" {
  description = "IP address for AZURE Non-Prod"
  type        = string
  default     = "10.110.0.20"  # Replace with the actual IP
}

variable "az_prod_ip" {
  description = "IP address for AZURE Prod"
  type        = string
  default     = "10.111.0.20"  # Replace with the actual IP
}

variable "aws_prod_man_ip" {
  description = "IP address for AWS Prod"
  type        = string
  default     = "10.102.0.42"  # Replace with the actual IP
}

variable "gcp_prod_shared_ip" {
  description = "IP address for GCP Prod Shared"
  type        = string
  default     = "10.120.0.3"   # Replace with the actual IP
}

variable "on_prem_ip" {
  description = "IP address for On-Prem"
  type        = string
  default     = "192.168.100.1"  # Replace with the actual IP
}

variable "docker_image" {
  description = "Docker image for Gatus"
  type        = string
  default     = "twinproduction/gatus"  # Replace with the actual image name
}

variable "docker_port_mapping" {
  description = "Port mapping for Docker container"
  type        = string
  default     = "80:8080"  # Replace with the desired port mapping
}

variable "config_yaml_path" {
  description = "Path to the Gatus config.yaml file"
  type        = string
  default     = "/opt/config.yaml"  # Replace with the desired path
}

variable "gatus_header_aws_nonprod_eng" {
  type        = string
  default     = "AWS VM2 - (NONPROD)ENG - FRANKFURT"  
}
variable "gatus_header_aws_prod_man" {
  type        = string
  default     = "AWS VM1 - (PROD) MAN - FRANKFURT"  
}
variable "gatus_header_az_nonprod_man" {
  type        = string
  default     = "AZURE VM2 - (NON PROD) - MAN - WEST EUROPE" 
}
variable "gatus_header_az_prod_eng" {
  type        = string
  default     = "AZURE VM1 - (PROD) ENG UK SOUTH"
}
variable "gatus_header_gcp_shared" {
  type        = string
  default     = "GCP VM1 - (PROD) SHARED - BELGIUM"
}



# variable "gatus_config" {
#   description = "Gatus configuration YAML content"
#   type        = string
#   default     = <<EOL
# header: "AWS VM2 - (NONPROD)ENG - FRANKFURT"
# endpoints:
#   - name: ICMP
#     url: "icmp://${var.az_non_prod_ip}"
#     group: NONPROD Manufacturing - AZURE
#     interval: 5s
#     conditions:
#       - "[CONNECTED] == true"
#   - name: HTTP
#     url: "http://${var.az_non_prod_ip}"
#     interval: 5s
#     group: NONPROD Manufacturing - AZURE
#     conditions:
#       - "[STATUS] == 200"
#   - name: ICMP
#     url: "icmp://${var.az_prod_ip}"
#     group: PROD Engineering - AZURE
#     interval: 5s
#     conditions:
#       - "[CONNECTED] == true"
#   - name: HTTP
#     url: "http://${var.az_prod_ip}"
#     interval: 5s
#     group: PROD Engineering - AZURE
#     conditions:
#       - "[STATUS] == 200"
#   - name: ICMP
#     url: "icmp://${var.aws_prod_man_ip}"
#     group: PROD Manufacturing - AWS
#     interval: 5s
#     conditions:
#       - "[CONNECTED] == true"
#   - name: HTTP
#     url: "http://${var.aws_prod_man_ip}"
#     interval: 5s
#     group: PROD Manufacturing - AWS
#     conditions:
#       - "[STATUS] == 200"
#   - name: ICMP
#     url: "icmp://${var.gcp_prod_shared_ip}"
#     group: PROD SHARED - GCP
#     interval: 5s
#     conditions:
#       - "[CONNECTED] == true"
#   - name: HTTP
#     url: "http://${var.gcp_prod_shared_ip}"
#     interval: 5s
#     group: PROD SHARED - GCP
#     conditions:
#       - "[STATUS] == 200"
#   - name: ICMP
#     url: "icmp://${var.on_prem_ip}"
#     group: ONPREM
#     interval: 5s
#     conditions:
#       - "[CONNECTED] == true"
# EOL
# }

# azure gatus 

# variables.tfvars
variable "resource_group_location" {
  description = "The location of the Azure resource group."
  type        = string
  default     = "UK South"
}

variable "network_interface_name" {
  description = "The name of the network interface for the VM."
  type        = string
  default     = "gatus-nic"
}

variable "network_interface_location" {
  description = "The location of the network interface."
  type        = string
  default     = "UK South"
}

variable "network_interface_subnet_id" {
  description = "The subnet ID for the network interface."
  type        = string
  default     = "/subscriptions/subscription_id/resourceGroups/resource_group_name/providers/Microsoft.Network/virtualNetworks/vnet_name/subnets/subnet_name"
}

variable "admin_username" {
  description = "The username for the VM administrator."
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "The password for the VM administrator."
  type        = string
  default     = "Password1234!" # You can replace this with your actual password or use SSH keys instead
}

variable "azureuser" {
  description = "The password for the VM administrator."
  type        = string
  default     = "Password1234!" # You can replace this with your actual password or use SSH keys instead
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
  default     = "az-uk-south-prod-eng"
}

variable "storage_account_name" {
  description = "The name of the Azure storage account."
  type        = string
  default     = "mystorageaccount"
}

variable "storage_account_type" {
  description = "The type of Azure storage account."
  type        = string
  default     = "Standard_LRS"
}

variable "boot_diagnostics_storage_account_name" {
  description = "The name of the storage account for boot diagnostics."
  type        = string
  default     = "bootdiagnosticsstorage"
}

variable "os_disk_name" {
  description = "The name of the OS disk for the virtual machine."
  type        = string
  default     = "exampleosdisk"
}





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


variable "az_spoke3_region" {
  default = "UK South"
}

variable "az_spoke3_name" {
  default = "az-r3-spoke1"
}

variable "az_spoke3_cidr" {
  default = "10.112.0.0/16"
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


# variable "name" {
#   description = "Custom name for VPC and sdwan headends"
#   type        = string
#   default     = ""
# }

# variable "region" {
#   description = "The AWS region to deploy this module in"
#   type        = string
#   default = "eu-central-1"
# }

# variable "cidr" {
#   description = "The CIDR range to be used for the VPC"
#   type        = string
#   default     = "172.16.1.0/24"
# }

# variable "transit_gw_obj" {
#   description = "Transit gateway object including attributes, to attach sdwan GW to"
# }

# variable "az1" {
#   description = "Availability zone 1, for headend deployment"
#   type        = string
#   default     = "a"
# }

# variable "az2" {
#   description = "Availability zone 2, for headend deployment"
#   type        = string
#   default     = "b"
# }

# variable "ha_gw" {
#   description = "Boolean to determine if module will be deployed in HA or single mode"
#   type        = bool
#   default     = false
# }

# variable "vedge_image_version" {
#   description = "Determines which image version will be deployed."
#   type        = string
#   default     = "20.3.1" #Make sure the version is available in the Marketplace
# }

# variable "csr_image_version" {
#   description = "Determines which image version will be deployed."
#   type        = string
#   default     = "17.3.3" #Make sure the version is available in the Marketplace
# }

# variable "image_type" {
#   description = "Determines whether CSR SDWAN (\"csr\") or vEdge (\"vedge\", default) image should be used."
#   type        = string
#   default     = "csr" #Use "csr" to select CSR image.
# }

# variable "instance_size" {
#   description = "AWS Instance size for the SDWAN gateways"
#   type        = string
#   default     = "t2.medium"
# }

# variable "tunnel_cidr" {
#   description = "CIDR to be used to create tunnel addresses"
#   type        = string
#   default     = "172.31.255.0/28"
# }

# variable "aviatrix_asn" {
#   description = "ASN To be used on Aviatrix Transit Gateway for BGP"
#   type        = string
#   default     = "65302"
# }

# variable "sdwan_asn" {
#   description = "ASN To be used on SDWAN Gateway for BGP"
#   type        = string
#   default     = "65501"
# }

# variable "aviatrix_tunnel_creation" {
#   description = "When set to true, the IPSEC tunnels will be provisioned to the Aviatrix transit gateway."
#   type        = bool
#   default     = true
# }

# variable "use_existing_vpc" {
#   description = "Set to true to use existing VPC."
#   type        = bool
#   default     = false
# }

# variable "vpc_id" {
#   description = "VPC ID, for using an existing VPC."
#   type        = string
#   default     = ""
# }

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

locals {
  sdwan_gw_subnet_id   = var.use_existing_vpc ? var.sdwan_gw_subnet_id : aws_subnet.sdwan_1[0].id
  sdwan_ha_subnet_id   = var.use_existing_vpc ? var.sdwan_ha_subnet_id : aws_subnet.sdwan_2[0].id
  sdwan_gw_subnet_cidr = var.use_existing_vpc ? var.sdwan_gw_subnet_cidr : aws_subnet.sdwan_1[0].cidr_block
  sdwan_ha_subnet_cidr = var.use_existing_vpc ? var.sdwan_ha_subnet_cidr : aws_subnet.sdwan_2[0].cidr_block
  # ami                  = length(regexall("vedge", lower(var.image_type))) > 0 ? data.aws_ami.vedge.id : data.aws_ami.csr.id
}


# Define variables
variable "use_existing_vpc" {
  description = "Flag to indicate whether to use an existing VPC"
  type        = bool
  default     = false
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "az1" {
  description = "Availability Zone 1"
  type        = string
  default     = "a"
}

variable "az2" {
  description = "Availability Zone 2"
  type        = string
  default     = "b"
}

variable "name" {
  description = "Name for resources"
  type        = string
  default     = ""
}

variable "tunnel_cidr" {
  description = "CIDR block for VPN tunnels"
  type        = string
  default     = "192.168.0.0/24"
}

variable "instance_size" {
  description = "Instance size for SDWAN Headend"
  type        = string
  default     = "t2.medium"
}

variable "second_interface" {
  description = "Flag to indicate whether to create a second network interface for SDWAN Headend"
  type        = bool
  default     = false
}

variable "ha_gw" {
  description = "Flag to indicate whether to create a high-availability SDWAN Headend"
  type        = bool
  default     = true
}

variable "aviatrix_tunnel_creation" {
  description = "Flag to indicate whether to create Aviatrix VPN tunnels"
  type        = bool
  default     = true
}

variable "aviatrix_asn" {
  description = "AS number for Aviatrix VPN"
  type        = number
  default     = 65302
}

variable "sdwan_asn" {
  description = "AS number for SDWAN"
  type        = number
  default     = 65001
}

variable "vpc_id" {
  type        = string
  default = "value"
}


# Add any additional variables as needed




