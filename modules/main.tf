resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "demo-vpc"
  }

}


resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet}"
  }
}


resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/16"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet}"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demoIGW"
  }
}


# Create the route table resources
resource "aws_route_table" "example" {
  count = var.aws_subnet


  vpc_id = aws_vpc.main.id
}

# Associate the route tables with the subnets
resource "aws_route_table_association" "example" {
  count = var.aws_subnet
  subnet_id      = aws_subnet.subnet1[count.index].id
  route_table_id = aws_route_table.example[count.index].id
}




resource "aws_instance" "web" {
  ami                             = "ami-07acf41a58c76cc08"
  instance_type                   = "t3.micro"
  subnet_id                       = aws_subnet.subnet1.id
  availability_zone               = "us-east-1a"
  ecs_associate_public_ip_address = true

  tags = {
    Name = "public-instance"
  }
}










#resource "aws_security_group" "allow_ssh" {
#  name        = "allow_ssh"
#  description = "Allow ssh inbound traffic"
#  vpc_id      = aws_vpc.main.id
#
#  ingress {
#    description      = "TLS from VPC"
#    from_port        = 22
#    to_port          = 22
#    protocol         = "tcp"
#    cidr_blocks      =  ["0.0.0.0/0"]
#
#  }
#
#  egress {
#    from_port        = 0
#    to_port          = 0
#    protocol         = "-1"
#    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
#  }
#
#  tags = {
#    Name = "allow_tls"
#  }
#}
