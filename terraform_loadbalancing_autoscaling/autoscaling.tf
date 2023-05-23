variable "ami_id" {}
variable "instance_type" {}

resource "aws_autoscaling_group" "tadpp_ag" {
    name = "tadpp_autoscaling_group"
    desired_capacity = 1
    min_size = 1
    max_size = 1
    health_check_grace_period = 400
    health_check_type = "ELB"
    force_delete = false
    launch_configuration = aws_launch_configuration.tadpp_lc.name
    vpc_zone_identifier = [var.subnet_id]
    target_group_arns = [aws_lb_target_group.tadpp_tg.arn]
}

resource "aws_launch_configuration" "tadpp_lc" {
    name = "tadpp_lauch_config"
    image_id = var.ami_id
    instance_type = var.instance_type
    key_name = "<key-name>"
    user_data = file("launch_configuration.txt")
    security_groups = [aws_security_group.asg_sg.id]
}