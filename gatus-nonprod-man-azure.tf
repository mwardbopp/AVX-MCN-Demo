resource "azurerm_resource_group" "gatus-nonprod-man" {
  name     = "gatus-nonprod-man-resources"
  location = "West Europe"
}

# resource "azurerm_virtual_network" "gatus-nonprod-man" {
#   name                = "gatus-nonprod-man-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.gatus-nonprod-man.location
#   resource_group_name = azurerm_resource_group.gatus-nonprod-man.name
# }

# resource "azurerm_subnet" "gatus-nonprod-man" {
#   name                 = "gatus-nonprod-man-subnet"
#   resource_group_name  = azurerm_resource_group.gatus-nonprod-man.name
#   virtual_network_name = azurerm_virtual_network.gatus-nonprod-man.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

resource "azurerm_public_ip" "gatus-nonprod-man" {
  name                = "gatus-nonprod-man-pip"
  location            = azurerm_resource_group.gatus-nonprod-man.location
  resource_group_name = azurerm_resource_group.gatus-nonprod-man.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "gatus-nonprod-man" {
  name                = "gatus-nonprod-man-nic"
  location            = azurerm_resource_group.gatus-nonprod-man.location
  resource_group_name = azurerm_resource_group.gatus-nonprod-man.name

  ip_configuration {
    name                          = "gatus-nonprod-man-internal"
    subnet_id                     = module.spoke_az_1.vpc.public_subnets[1].subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address =  var.az_non_prod_ip
    public_ip_address_id          = azurerm_public_ip.gatus-nonprod-man.id
  }
}

resource "azurerm_linux_virtual_machine" "gatus-nonprod-man" {
  name                = "gatus-nonprod-man-vm"
  location            = azurerm_resource_group.gatus-nonprod-man.location
  resource_group_name = azurerm_resource_group.gatus-nonprod-man.name
  network_interface_ids = [azurerm_network_interface.gatus-nonprod-man.id]
  size                = "Standard_DS2_v2"

  admin_username = "azureuser"
  admin_password = var.azureuser
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  custom_data = base64encode(data.cloudinit_config.az-westeurope-nonprod-man.rendered)
  tags = {
    environment = "nonprod"
    businessunit = "manufacturing"
  }   
}

data "cloudinit_config" "az-westeurope-nonprod-man" {
  gzip          = false
  base64_encode = false


  part {
    content_type = "text/x-shellscript"
    filename     = "example.sh"
    content = <<-EOF
#!/bin/bash
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker


# Create the config.yaml file
cat <<EOL > /opt/config.yaml
ui:
  header: "${var.gatus_header_az_nonprod_man}"
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
