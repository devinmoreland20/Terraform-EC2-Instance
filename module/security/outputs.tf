# ----- modules/security/outputs.tf

output "webserver_sg" {
  value = aws_security_group.webserver.id
}

