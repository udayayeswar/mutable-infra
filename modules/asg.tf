resource "aws_launch_template" "default" {
  name                   = "demo-launch-template"
  image_id               = "ami-0715c1897453cabd1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  instance_market_options {
    market_type = "spot"
  }
  user_data = filebase64("${path.module}/ansiblepull.sh")
}


resource "aws_autoscaling_group" "asg" {
  name             = "demo_asg"
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  vpc_zone_identifier = [aws_subnet.subnet1.id , aws_subnet.subnet2.id]

  launch_template {
    id      = aws_launch_template.default.id
    version = "$Latest"
  }


}