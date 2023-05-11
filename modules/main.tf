resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "demo-vpc"
  }

}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demo1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "demo1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demoIGW"
  }
}

resource "aws_instance" "web" {
  ami                = "ami-07acf41a58c76cc08"
  instance_type      = "t3.micro"
  subnet_id          = aws_subnet.subnet1.id
   availability_zone = "us-east-1c"
  tags = {
    Name = "demo-instance1"
  }
}

resource "aws_instance" "web1" {
  ami           = "ami-07acf41a58c76cc08"
  instance_type = "t3.micro"
  subnet_id     =aws_subnet.subnet2.id
  availability_zone = "us-east-1c"
  tags = {
    Name = "demo-instance2"
  }
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "igw-02d7e6a9c6afda95e"
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = "igw-02d7e6a9c6afda95e"
  }

  tags = {
    Name = "demoRT"
  }
}



resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      =  ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
