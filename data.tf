data "aws_ami" "vedge" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*cisco*"]
  }
  owners = ["679593333241"] # Marketplace
}

data "aws_ami" "csr" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*CSR-17.03.07-BYOL-624f5bb1-7f8e-4f7c-ad2c-03ae1cd1c2d3*"]
  }
  owners = ["679593333241"] # Marketplace
}