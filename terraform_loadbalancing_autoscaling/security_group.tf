resource "aws_security_group" "lb_sg"{
    name = "ELB_sg_tadpp"
    description = "elastic load balancer security group for tadpp project"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "asg_sg"{
    name = "ASG_sg_tadpp"
    description = "Autoscaling group security group for tadpp project"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.lb_sg.id]
        # cidr_blocks = ["0.0.0.0/0"]
    }
    

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    depends_on = [
      aws_security_group.lb_sg
    ]
}