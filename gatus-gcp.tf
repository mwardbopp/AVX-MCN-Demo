
resource "google_compute_address" "static_ip" {
  name = "my-static-ip"
  address = var.gcp_prod_shared_ip
  subnetwork = module.spoke_gcp_1.vpc.id
  region      = "europe-west1"
  address_type = "INTERNAL"
}

# Define the VM instance with user data using cloudinit_config
resource "google_compute_instance" "my_instance" {
  name         = "gcp-shared"  # Change the VM instance name to "gcp-shared"
  machine_type = "n1-standard-2"  # You can choose a different machine type
  zone         = "europe-west1-b"  # Choose your desired zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"  # Use Ubuntu 18.04 LTS image
    }
  }

  network_interface {
    subnetwork = module.spoke_gcp_1.vpc.id
    network_ip = google_compute_address.static_ip.address
    access_config {

    }
    }


  tags = ["my-linux-vm","shared"]

metadata_startup_script = <<-EOF
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
      header: "${var.gatus_header_gcp_shared}"
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
  allow_stopping_for_update = true
}


# Allow ICMP traffic (ping) from anywhere
resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  network = module.spoke_gcp_1.vpc.id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# Allow SSH (port 22) from anywhere
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = module.spoke_gcp_1.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Allow HTTP (port 80) from anywhere
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = module.spoke_gcp_1.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

