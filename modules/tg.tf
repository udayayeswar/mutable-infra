resource "aws_lb_target_group" "example" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"


  health_check {
    enabled   = true
    port      = 1337
    interval  = 6
    timeout   = 5
    healthy   = 2
    unhealthy = 2
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}