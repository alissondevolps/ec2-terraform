######################################
# criando ec2
#######################################
resource "aws_instance" "web_server" {
  ami                    = "ami-0cd59ecaf368e5ccf"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.new-subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.new-sg-web.id]
  iam_instance_profile = aws_iam_instance_profile.default.name

  tags = {
    Name = "${var.prefix}-web-server"
  }
  user_data = file("userdata.sh")
}

######################################
# criando role SSM e atachando para ec2
#######################################
resource "aws_iam_role" "role-ssm" {
  name               = "role-ssm"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "default" {
  name = "default"
  role = aws_iam_role.role-ssm.name

}


resource "aws_iam_policy_attachment" "acesso-ssm" {
  name       = "acesso-ssm"
  roles      = [aws_iam_role.role-ssm.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}