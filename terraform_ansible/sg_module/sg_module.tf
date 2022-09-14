variable "vpc_id"{
    type = string
    default = "vpc-0ab05d5ad8dae6960"
}

variable "sg_name" {
    type = string
}

resource "aws_security_group" "ec2_security_group"{
    name = var.sg_name
    description = "security group created from module - terraform"
    vpc_id = var.vpc_id

    # Allow inbound connection for ssh
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]     # Source
    }

    # Allow inbound connection for http
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]     # Source
    }

    # Allow any outbound connection needed
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]     # Destination
    }
}


output "securityGp_Id"{
    value = aws_security_group.ec2_security_group.id
}

