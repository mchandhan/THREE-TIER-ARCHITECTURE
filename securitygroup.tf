# ALB SG
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.three_tier_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web Tier SG
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.three_tier_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
}

# App Tier SG
resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.three_tier_vpc.id

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }
}

# DB SG
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.three_tier_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
}

