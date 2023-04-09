output "pri-sn" {
  value = aws_subnet.pri-sn.id
}
output "pub-sn" {
  value = aws_subnet.pub-sn.id
}
output "app-sg" {
  value = aws_security_group.app-sg.id
}
output "elb-sg" {
  value = aws_security_group.elb-sg.id
}
output "backend-sg" {
  value = aws_security_group.backend-sg.id
}