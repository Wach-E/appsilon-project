resource "aws_vpc" "infra-vpc" {
  enable_dns_hostnames = true
  cidr_block           = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "infra-subnet" {
  source                 = "./modules/subnet/"
  vpc_id                 = aws_vpc.infra-vpc.id
  subnet_cidr_block      = var.subnet_cidr_block
  az                     = var.az
  env_prefix             = var.env_prefix
  default_route_table_id = aws_vpc.infra-vpc.default_route_table_id
}

module "my-app-webserver" {
  source              = "./modules/webserver/"
  vpc_id              = aws_vpc.infra-vpc.id
  ip_address_range    = var.ip_address_range
  env_prefix          = var.env_prefix
  instance_type       = var.instance_type
  subnet_id           = module.infra-subnet.subnet.id
  az                  = var.az
  ami                 = var.ami
  public_key_location = var.public_key_location
}


resource "null_resource" "remote_node_ip" {
  triggers = {
    trigger = module.my-app-webserver.ec2-public_ip
  }

  provisioner "local-exec" {
    working_dir = "../../configure_infrastructure"
    command     = "ansible-playbook --inventory ${module.my-app-webserver.ec2-public_ip}, --private-key ${var.ssh_key_private} --user ubuntu appsilon-playbook.yaml"
  }
}

