


# module "azurelinux-app10" {
#   source = "github.com/patelavtx/azure-linux-passwd.git"
#   count = 1
#   #source = "github.com/patelavtx/terraform-azure-azure-linux-vm-public.git"
#   #public_key_file = var.public_key_file
#   region = module.spoke_az_1.vpc.region
#   resource_group_name = module.spoke_az_1.vpc.resource_group
#   subnet_id = module.spoke_az_1.vpc.subnets.*.subnet_id[2]
#   vm_name = "App10VMNic-${count.index}"
#   admin_password = var.admin_password
#   tags = var.app10_tags
#   depends_on = [ module.spoke_az_1 ]
# }


# output "app10-vm1" {
#   value = module.azurelinux-app10[0]
# }