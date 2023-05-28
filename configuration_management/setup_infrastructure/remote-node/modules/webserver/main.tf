# Create ssh-key pair from local public key
# Similar to import keypair
resource "aws_key_pair" "ssh-key" {
  key_name   = "remote-node-ssh"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "myapp-server" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.my-app-sg.id]
  availability_zone      = var.az

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  tags = {
    Name = "${var.env_prefix}-server"
  }
}

resource "aws_security_group" "my-app-sg" {
  name   = "my-app-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env_prefix}:infra-vpc/sg"
  }
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.my-app-sg.id

  from_port   = local.ssh_port
  to_port     = local.ssh_port
  protocol    = local.tcp_protocol
  cidr_blocks = [var.ip_address_range]
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.my-app-sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

locals {
  ssh_port     = 22
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}