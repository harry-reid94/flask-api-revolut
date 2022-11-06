resource "aws_lb" "lb" {
  name            = "flask-api-lb"
  subnets         = aws_subnet.public_subnet.*.id
  security_groups = [aws_security_group.lb_sg.id]
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "flask-api-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.id
    type             = "forward"
  }
}