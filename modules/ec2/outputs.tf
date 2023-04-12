output "app" {
  value = aws_instance.app[*].id
}
/*output "app02" {
  value = aws_instance.app.1.id
}*/
output "ec2ip" {
  value = aws_instance.app[*].private_ip
}
/*output "ec2ip2" {
  value = aws_instance.app.1.private_ip
}*/