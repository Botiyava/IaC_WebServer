output "webserver_instance_id" {
  value = aws_instance.myWebServer.id
}
output "webserver_public_ip"{
  value = aws_instance.myWebServer.public_ip
}
