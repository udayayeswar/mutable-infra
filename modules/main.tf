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
    Name = "public-subnet"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demoIGW"
  }
}
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example-route-table"
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.example.id
}



## Create the route table resources
#resource "aws_route_table" "example" {
#  count = var.aws_subnet
#
#
#  vpc_id = aws_vpc.main.id
#}
#
## Associate the route tables with the subnets
#resource "aws_route_table_association" "example" {
#  subnet_id      = aws_subnet.subnet1.id
#  route_table_id = aws_route_table.example.id
#}
#
#resource "aws_route_table_association" "example1" {
#  subnet_id      = aws_subnet.subnet1.id
#  route_table_id = aws_route_table.example.id
#}

resource "aws_instance" "bastion_host" {
  ami                    = "ami-0715c1897453cabd1"
  instance_type          = "t3.micro"
  key_name               = "new-key-pair"
  subnet_id              = aws_subnet.subnet1.id
  associate_public_ip_address = true

  # Security Group for SSH access
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add any additional inbound rules as needed
}



resource "aws_instance" "web1" {
  ami                             = "ami-0715c1897453cabd1"
  instance_type                   = "t3.micro"
  subnet_id                       = aws_subnet.subnet2.id
  availability_zone               = "us-east-1a"


  tags = {
    Name = "private-instance"
  }
}

resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.subnet2.id
}

resource "aws_launch_template" "default" {
  name = "demo-launch-template"
  image_id = "ami-0715c1897453cabd1"
  instance_type = "t2.micro"
}


resource "aws_autoscaling_group" "asg" {
  name             = "demo_asg"
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  vpc_zone_identifier = [aws_subnet.subnet1.id]

  launch_template {
    id      = aws_launch_template.default.id
    version = "$Latest"
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
