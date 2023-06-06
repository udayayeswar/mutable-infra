resource "aws_lb" "test" {
  name               = "loadbalancer1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_ssh.id]
  subnets            = [aws_subnet.subnet1.id]
}