variable "subnet_id" {}
variable "subnet_id_2"{}

resource "aws_lb" "tadpp_lb" {
  name = "elb-lb-tadpp"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb_sg.id]
  subnets = [var.subnet_id, var.subnet_id_2]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "tadpp_tg" {
    name = "tadpp-lb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
}

resource "aws_lb_listener" "tadpp_lb_listener" {
    load_balancer_arn = aws_lb.tadpp_lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tadpp_tg.arn
    }
}