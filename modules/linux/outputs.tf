output "instance_id" {
  value = aws_instance.linux-server.id
}

output "server_public_ip" {
  value = aws_instance.linux-server.public_ip
}

output "vm_linux_server_instance_public_dns" {
  value = aws_instance.linux-server.public_dns
}
