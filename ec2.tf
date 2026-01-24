resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  security_groups = [aws_security_group.web_sg.id]

  user_data = <<EOF
#!/bin/bash
yum install -y httpd
echo "<h1>Web Tier</h1>" > /var/www/html/index.html
systemctl start httpd
EOF
}

resource "aws_instance" "app" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_1.id
  security_groups = [aws_security_group.app_sg.id]
}

