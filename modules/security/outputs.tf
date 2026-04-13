output "security_group_id" {
  value = aws_security_group.aws-linux-sg.id
}
output "key_name" {
  value = aws_key_pair.key_pair.key_name
}
