#------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
# Made by Leonid Shalaev
#------------------------------------

provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "myWebServer" {
  ami                    = "ami-0c6ebbd55ab05f070" # Ubuntu Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webServerSG.id]
  user_data              = templatefile("externalScripts/user_data.tpl",{
    name = "Leo",
    surname = "忘却 強すぎます",
    names = ["Go", "C++", "Python", "Julia"]
  })

  tags = {
    Name = "myWebServer"
  }
}

resource "aws_security_group" "webServerSG" {
  name        = "WebServer Security Group"
  description = "Security group for web servers"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HTTP-HTTPS"
  }
}