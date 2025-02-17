################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


# data "aws_ami" "csr" {
#   owners      = ["679593333241"] # Cisco Systems
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["cisco_CSR-*"]
#   }
# }

################################
###
### CSR INFRA
###
################################



#Edge VPC
resource "aws_vpc" "sdwan" {
#   count                = var.use_existing_vpc ? 0 : 1
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = length(var.name) > 0 ? "avx-${var.name}-sdwan-edge" : "avx-${var.region}-sdwan-edge"
  }
}

#Subnets
resource "aws_subnet" "sdwan_1" {
  count             = var.use_existing_vpc ? 0 : 1
  availability_zone = "${var.region}${var.az1}"
  vpc_id            = aws_vpc.sdwan.id
  cidr_block        = cidrsubnet(var.cidr, 1, 0)
}

resource "aws_subnet" "sdwan_2" {
  count             = var.use_existing_vpc ? 0 : 1
  availability_zone = "${var.region}${var.az2}"
  vpc_id            = aws_vpc.sdwan.id
  cidr_block        = cidrsubnet(var.cidr, 1, 1)
}

#IGW
resource "aws_internet_gateway" "sdwan" {
  count  = var.use_existing_vpc ? 0 : 1
  vpc_id = aws_vpc.sdwan.id
}

#Default route
resource "aws_route" "default_vpc1" {
  count                  = var.use_existing_vpc ? 0 : 1
  route_table_id         = aws_vpc.sdwan.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sdwan[0].id
}

#Security Group
resource "aws_security_group" "sdwan" {
  name   = "sdwan"
  vpc_id = var.use_existing_vpc ? var.vpc_id : aws_vpc.sdwan.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### S2C CONFIG
###
################################



#Random string for secret pre-shared-key
resource "random_string" "psk" {
  length  = 100
  special = false #Long key, without special chars to prevent issues.
}

locals {
  tunnel_subnetmask    = cidrnetmask(cidrsubnet(var.tunnel_cidr, 2, 0))
#   tunnel_masklength    = split("/", cidrsubnet(var.tunnel_cidr, 2, 0))[1]
  tunnel_masklength    = "30"
  gw1_tunnel1_avx_ip   = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 0), 1)
  gw1_tunnel1_sdwan_ip = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 0), 2)
  gw1_tunnel2_avx_ip   = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 1), 1)
  gw1_tunnel2_sdwan_ip = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 1), 2)
  gw2_tunnel1_avx_ip   = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 2), 1)
  gw2_tunnel1_sdwan_ip = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 2), 2)
  gw2_tunnel2_avx_ip   = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 3), 1)
  gw2_tunnel2_sdwan_ip = cidrhost(cidrsubnet(var.tunnel_cidr, 2, 3), 2)
}


################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### CSR INSTANCE
###
################################



#SDWAN Headend 1
resource "aws_instance" "headend_1" {
  ami                         = data.aws_ami.csr
  instance_type               = var.instance_size
  subnet_id                   = aws_subnet.sdwan_1[0].id
  associate_public_ip_address = true
  key_name                    = "wardbopp-keypair"
  security_groups             = [aws_security_group.sdwan.id]
  lifecycle {
    ignore_changes = [security_groups]
  }
  source_dest_check = false
  private_ip        = cidrhost(aws_subnet.sdwan_1[0].cidr_block, 10)

  tags = {
    Name = length(var.name) > 0 ? "${var.name}-headend1" : "avx-sdwan-edge-headend1",
  }
}

resource "aws_network_interface" "headend_1_eth1" {
  count             = var.second_interface ? 1 : 0
  subnet_id         = aws_subnet.sdwan_1[0].id
  security_groups   = [aws_security_group.sdwan.id]
  source_dest_check = false

  attachment {
    instance     = aws_instance.headend_1.id
    device_index = 1
  }
}

#SDWAN Headend 2 (HA)
# resource "aws_instance" "headend_2" {
#   count                       = var.ha_gw ? 1 : 0
#   ami                         = "ami-0c11bed50cac948f8"
#   instance_type               = var.instance_size
#   subnet_id                   = local.sdwan_ha_subnet_id
#   associate_public_ip_address = true
#   key_name = "wardbopp-keypair"
#   security_groups             = [aws_security_group.sdwan.id]
#   lifecycle {
#     ignore_changes = [security_groups]
#   }
#   source_dest_check = false
#   private_ip        = cidrhost(local.sdwan_ha_subnet_cidr, 10)

#   tags = {
#     Name = length(var.name) > 0 ? "${var.name}-headend2" : "avx-sdwan-edge-headend2",
#   }
# }

# resource "aws_network_interface" "headend_2_eth1" {
#   count             = var.ha_gw ? (var.second_interface ? 1 : 0) : 0
#   subnet_id         = local.sdwan_ha_subnet_id
#   security_groups   = [aws_security_group.sdwan.id]
#   source_dest_check = false

#   attachment {
#     instance     = aws_instance.headend_2[0].id
#     device_index = 1
#   }
# }

resource "aws_eip" "headend_1_eth0" {
  vpc = true
}

resource "aws_eip" "headend_1_eth1" {
  count = var.second_interface ? 1 : 0
  vpc   = true
}

# resource "aws_eip" "headend_2_eth0" {
#   count = var.ha_gw ? 1 : 0
#   vpc   = true
# }

# resource "aws_eip" "headend_2_eth1" {
#   count = var.ha_gw ? (var.second_interface ? 1 : 0) : 0
#   vpc   = true
# }

resource "aws_eip_association" "eip_headend_1_eth0" {
  network_interface_id = aws_instance.headend_1.primary_network_interface_id
  allocation_id        = aws_eip.headend_1_eth0.id
}

resource "aws_eip_association" "eip_headend_1_eth1" {
  count                = var.second_interface ? 1 : 0
  network_interface_id = aws_network_interface.headend_1_eth1[0].id
  allocation_id        = aws_eip.headend_1_eth1[0].id
}

# resource "aws_eip_association" "eip_headend_2_eth0" {
#   count                = var.ha_gw ? 1 : 0
#   network_interface_id = aws_instance.headend_2[0].primary_network_interface_id
#   allocation_id        = aws_eip.headend_2_eth0[0].id
# }

# resource "aws_eip_association" "eip_headend_2_eth1" {
#   count = var.ha_gw ? (var.second_interface ? 1 : 0) : 0
#   network_interface_id = aws_network_interface.headend_2_eth1[0].id
#   allocation_id        = aws_eip.headend_2_eth1[0].id
# }


################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################
################################################################################################################################################################


################################
###
### S2C CONFIG
###
################################




#Aviatrix VPN Tunnels
resource "aviatrix_transit_external_device_conn" "sdwan" {
  count                     = var.aviatrix_tunnel_creation ? 1 : 0
  vpc_id                    = module.framework.transit["transit2"].transit_gateway.vpc_id
  connection_name           = "SDWAN-${var.region}"
  gw_name                   = module.framework.transit["transit2"].transit_gateway.gw_name
  connection_type           = "bgp"
  phase1_remote_identifier  = ["10.0.0.10"]
  ha_enabled                = var.ha_gw
  bgp_local_as_num          = var.aviatrix_asn
  bgp_remote_as_num         = var.sdwan_asn
  remote_gateway_ip         = var.second_interface ? aws_eip.headend_1_eth1[0].public_ip : aws_eip.headend_1_eth0.public_ip
  pre_shared_key            = var.ha_gw ? "${random_string.psk.result}-headend1" : random_string.psk.result
  local_tunnel_cidr         = var.ha_gw ? "${local.gw1_tunnel1_avx_ip}/${local.tunnel_masklength},${local.gw1_tunnel2_avx_ip}/${local.tunnel_masklength}" : "${local.gw1_tunnel1_avx_ip}/${local.tunnel_masklength}"
  remote_tunnel_cidr        = var.ha_gw ? "${local.gw1_tunnel1_sdwan_ip}/${local.tunnel_masklength},${local.gw1_tunnel2_sdwan_ip}/${local.tunnel_masklength}" : "${local.gw1_tunnel1_sdwan_ip}/${local.tunnel_masklength}"
#   backup_local_tunnel_cidr  = var.ha_gw ? "${local.gw2_tunnel1_avx_ip}/${local.tunnel_masklength},${local.gw2_tunnel2_avx_ip}/${local.tunnel_masklength}" : null
#   backup_remote_tunnel_cidr = var.ha_gw ? "${local.gw2_tunnel1_sdwan_ip}/${local.tunnel_masklength},${local.gw2_tunnel2_sdwan_ip}/${local.tunnel_masklength}" : null
#   backup_pre_shared_key     = var.ha_gw ? "${random_string.psk.result}-headend2" : null
#   backup_remote_gateway_ip  = var.ha_gw ? (var.second_interface ? aws_eip.headend_2_eth1[0].public_ip : aws_eip.headend_2_eth0[0].public_ip) : null
#   backup_bgp_remote_as_num  = var.ha_gw ? var.sdwan_asn : null
}
