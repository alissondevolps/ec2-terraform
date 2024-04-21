output "public_ip_address" {
  value = aws_instance.web_server.public_ip
}

output "id_da_instancia_ec2" {
  value = aws_instance.web_server.id
}
