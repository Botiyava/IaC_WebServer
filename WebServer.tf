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
  user_data              = <<EOF
#!/bin/bash
apt -y update
apt -y install apache2
myip=`curl http://169.254.169.254/update-rc.dlatest/meta-data/local-ipv4`
echo "<html><body><h1>WebServer with IP:$myip</h1><br><h1>Build by Terraform!</h1></body></html>" > /var/www/html/index.html
sudo service apache2 start
update-rc.d apache2 defaults
EOF

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