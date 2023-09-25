output "instance_network_ip" {
  value = google_compute_instance.my_instance.network_interface.0.network_ip
}

output "azure_public_ip_name-gatus-nonprod-man" {
  value = azurerm_public_ip.gatus-nonprod-man.name
}


output "aws_ec2_instance_aws-eu-central-nonprod-eng_public_ip" {
  value = module.ec2_instance_aws-eu-central-nonprod-eng.public_ip
}

output "aws_ec2_instance_aws-eu-central-prod-man_public_ip" {
  value = module.ec2_instance_aws-eu-central-prod-man.public_ip
}

output "azure_public_ip_name-gatus-prod-eng" {
  value = azurerm_public_ip.gatus-prod-eng.name
}

output "azure_network_interface_private_ip-gatus-prod-eng" {
  value = azurerm_network_interface.gatus-prod-eng.ip_configuration[0].private_ip_address
}


output "azure_network_interface_private_ip-gatus-nonprod-man" {
  value = azurerm_network_interface.gatus-nonprod-man.ip_configuration[0].private_ip_address
}