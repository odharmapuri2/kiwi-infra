/*output "app" {
  value = aws_instance.app.id
}*/
output "app01" {
  value = aws_instance.app.0.id
}
output "app02" {
  value = aws_instance.app.1.id
}