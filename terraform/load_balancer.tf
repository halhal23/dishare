resource "aws_lb_target_group" "dishare_alb_nuxt_tg" {
  name     = "dishare-alb-nuxt-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.dishare-vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = 50
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

}
resource "aws_lb_target_group" "dishare_alb_rails_tg" {
  name     = "dishare-alb-rails-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.dishare-vpc.id
  target_type = "ip"
  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    port                = 3000
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = 50
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb" "dishare_alb" {
  name            = "dishare-alb"
  load_balancer_type = "application"
  subnets         = [
    aws_subnet.dishare-public-sb-1a.id,
    aws_subnet.dishare-public-sb-1c.id
  ]
  security_groups = [
    aws_security_group.dishare-alb-sg.id
  ]
  tags = {
    Name        = "dishare_alb"
  }
}

resource "aws_lb_listener" "dishare_http_listener" {
  load_balancer_arn = aws_lb.dishare_alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.dishare_alb_nuxt_tg.arn
    type             = "forward"
  }
}
resource "aws_lb_listener" "dishare_api_listener" {
  load_balancer_arn = aws_lb.dishare_alb.arn
  port              = "3000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.dishare_alb_rails_tg.arn
    type             = "forward"
  }
}