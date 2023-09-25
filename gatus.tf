data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.aws_linux_ami_search_name]
  }
}

resource "aws_security_group" "gatus_server_sg" {
  name        = "gatus-sg"
  description = "SG for Gatus, wide open"
  vpc_id      = module.spoke_aws_1.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/8"]
  security_group_id = aws_security_group.gatus_server_sg.id
}

resource "aws_security_group_rule" "ingress_from_myIP" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gatus_server_sg.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gatus_server_sg.id
}

resource "aws_security_group" "gatus_server_sg_2" {
  name        = "gatus-sg-2"
  description = "SG for Gatus 2, wide open"
  vpc_id      = module.spoke_aws_2.vpc.vpc_id
}

resource "aws_security_group_rule" "ingress_vpc_2" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/8"]
  security_group_id = aws_security_group.gatus_server_sg_2.id
}

resource "aws_security_group_rule" "ingress_from_myIP_2" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gatus_server_sg_2.id
}

resource "aws_security_group_rule" "egress_2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gatus_server_sg_2.id
}


data "cloudinit_config" "aws-eu-central-prod-man" {
  gzip          = false
  base64_encode = false


  part {
    content_type = "text/x-shellscript"
    filename     = "example.sh"
    content = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Create the config.yaml file
cat <<EOL > /opt/config.yaml
ui:
  header: "${var.gatus_header_aws_prod_man}"
endpoints:
  - name: ICMP
    url: "icmp://${var.az_non_prod_ip}"
    group: NONPROD Manufacturing - AZURE
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.az_non_prod_ip}"
    interval: 5s
    group: NONPROD Manufacturing - AZURE
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.az_prod_ip}"
    group: PROD Engineering - AZURE
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.az_prod_ip}"
    interval: 5s
    group: PROD Engineering - AZURE
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.aws_prod_man_ip}"
    group: PROD Manufacturing - AWS
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.aws_prod_man_ip}"
    interval: 5s
    group: PROD Manufacturing - AWS
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.gcp_prod_shared_ip}"
    group: PROD SHARED - GCP
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.gcp_prod_shared_ip}"
    interval: 5s
    group: PROD SHARED - GCP
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.on_prem_ip}"
    group: ONPREM
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
EOL

# Start Docker container
sudo docker run -d --restart unless-stopped --name gatus -p ${var.docker_port_mapping} --mount type=bind,source="/opt/config.yaml",target=/config/config.yaml ${var.docker_image}
EOF
  }
}

data "cloudinit_config" "aws-eu-central-nonprod-eng" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = "example.sh"
    content = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Create the config.yaml file
cat <<EOL > /opt/config.yaml
ui:
  header: "${var.gatus_header_aws_nonprod_eng}"
endpoints:
  - name: ICMP
    url: "icmp://${var.az_non_prod_ip}"
    group: NONPROD Manufacturing - AZURE
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.az_non_prod_ip}"
    interval: 5s
    group: NONPROD Manufacturing - AZURE
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.az_prod_ip}"
    group: PROD Engineering - AZURE
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.az_prod_ip}"
    interval: 5s
    group: PROD Engineering - AZURE
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.aws_prod_man_ip}"
    group: PROD Manufacturing - AWS
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.aws_prod_man_ip}"
    interval: 5s
    group: PROD Manufacturing - AWS
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.gcp_prod_shared_ip}"
    group: PROD SHARED - GCP
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
  - name: HTTP
    url: "http://${var.gcp_prod_shared_ip}"
    interval: 5s
    group: PROD SHARED - GCP
    conditions:
      - "[STATUS] == 200"
  - name: ICMP
    url: "icmp://${var.on_prem_ip}"
    group: ONPREM
    interval: 5s
    conditions:
      - "[CONNECTED] == true"
EOL

# Start Docker container
sudo docker run -d --restart unless-stopped --name gatus -p ${var.docker_port_mapping} --mount type=bind,source="/opt/config.yaml",target=/config/config.yaml ${var.docker_image}
EOF
  }
}

module "ec2_instance_aws-eu-central-nonprod-eng" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                    = "aws-eu-central-nonprod-eng"
  ami                     = data.aws_ami.amazon_linux.id
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.gatus_server_sg.id]
  associate_public_ip_address = true
  disable_api_termination = false
  key_name                = "wardbopp-keypair"
  monitoring              = true
  subnet_id               = module.spoke_aws_1.vpc.public_subnets[0].subnet_id
  private_ip              = var.aws_non_prod_eng_ip
  user_data_replace_on_change = true

  user_data = data.cloudinit_config.aws-eu-central-nonprod-eng.rendered
    tags = {
    environment = "nonprod"
    businessunit = "engineering"
  }
}

module "ec2_instance_aws-eu-central-prod-man" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name                    = "aws-eu-central-prod-man"
  ami                     = data.aws_ami.amazon_linux.id
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.gatus_server_sg_2.id]
  associate_public_ip_address = true
  disable_api_termination = false
  key_name                = "wardbopp-keypair"
  monitoring              = true
  subnet_id               = module.spoke_aws_2.vpc.public_subnets[0].subnet_id
  private_ip              = var.aws_prod_man_ip
  user_data_replace_on_change = true

  user_data = data.cloudinit_config.aws-eu-central-prod-man.rendered
  tags = {
    environment = "prod"
    businessunit = "manufacturing"
  }
}
