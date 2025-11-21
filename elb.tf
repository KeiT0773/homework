# ELB
resource "aws_lb" "aws-study-lb" {
  name               = "aws-study-lb-${var.my_env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb.id]
  subnets            = [aws_subnet.PublicAZ1a.id, aws_subnet.PublicAZ1c.id]

  enable_deletion_protection = false

  tags = {
    Name = "aws-study-elb-${var.my_env}"
  }
}

output "elb_id" {
  value = aws_lb.aws-study-lb.id
}

# ELB Target group
resource "aws_lb_target_group" "aws-study-lb-tg" {
  name        = "aws-study-lb-tg-${var.my_env}"
  port        = 8080
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpc.id

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200,300,301"
  }
  tags = {
    Name = "aws-study-elb-group-${var.my_env}"
  }
}
# ELB Targets
resource "aws_lb_target_group_attachment" "ec2_1" {
  target_group_arn = aws_lb_target_group.aws-study-lb-tg.arn
  target_id        = aws_instance.ec2_1.id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "ec2_2" {
  target_group_arn = aws_lb_target_group.aws-study-lb-tg.arn
  target_id        = aws_instance.ec2_2.id
  port             = 8080
}

# ELB Listener
resource "aws_lb_listener" "aws-study-lb-listener" {
  load_balancer_arn = aws_lb.aws-study-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws-study-lb-tg.arn
  }
  tags = {
    Name = "aws-study-elb-listener-${var.my_env}"
  }
}