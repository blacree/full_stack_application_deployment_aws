variable "ami_id"{
    type=string
    default = "ami-052efd3df9dad4825"
}

variable "ansible_user" {}
variable "ansible_ssh_key" {}
variable "ansible_file" {}
variable "sg_id"{}
variable "ec2_name" {}

resource "aws_instance" "ami_instance"{
    ami = var.ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = [var.sg_id]
    key_name = "blacree"

    tags = {
        Name = var.ec2_name
    }

    provisioner "remote-exec"{
        inline = [
          "echo ssh is now available"
        ]

        connection {
          type = "ssh"
          user = var.ansible_user
          host = aws_instance.ami_instance.public_ip
          private_key = file(var.ansible_ssh_key)
        }
    }

    provisioner "local-exec" {
      # command = "ansible-playbook -i ${aws_instance.ami_instance.public_ip}, --ask-vault-pass ${var.ansible_file}"
      command = "ansible-playbook -i ${aws_instance.ami_instance.public_ip}, ${var.ansible_file}"
    }
}