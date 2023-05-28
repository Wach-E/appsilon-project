output "ec2-public_ip" {
  value = aws_instance.myapp-server.public_ip
}