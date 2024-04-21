resource "aws_vpc" "new-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "new-subnet-1" {
    availability_zone = "us-east-1a"
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-subnet-1-tag"
    }
  
}

resource "aws_subnet" "new-subnet-2" {
    availability_zone = "us-east-1b"
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-subnet-2-tag"
    }
  
}

resource "aws_internet_gateway" "new-igw" {
    vpc_id = aws_vpc.new-vpc.id
    tags = {
      Name = "${var.prefix}-igw"
    }
  
}

resource "aws_route_table" "new-rtb" {
    vpc_id = aws_vpc.new-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.new-igw.id
    }
    tags = {
      Name = "${var.prefix}-rtb"
    }
}

resource "aws_route_table_association" "new-rtb-association1" {
    route_table_id = aws_route_table.new-rtb.id
    subnet_id = aws_subnet.new-subnet-1.id
  
}

resource "aws_route_table_association" "new-rtb-association2" {
    route_table_id = aws_route_table.new-rtb.id
    subnet_id = aws_subnet.new-subnet-2.id
  
}

# Definição do security group
resource "aws_security_group" "new-sg-web" {
  name        = "web-sg"  
  description = "Security group para dar acesso ao app web"
  vpc_id      = aws_vpc.new-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acesso pela a porta 80 por ipv4"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    description = "Acesso pela a porta 80 por ipv6"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name = "${var.prefix}-sg"
  }
}
