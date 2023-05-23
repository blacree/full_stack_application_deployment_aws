terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.22.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    profile = "default"
}

# variable "ec2_instances" {
#   type=list
#   default = ["ec2 instance moudle one", "ec2 instance module two"]
# }

locals {
  ansible_user = "ubuntu"
  ansible_ssh_key = "<ssh_key_path>"
  ansible_file = "ansible_djangoapp_config.yaml"
}

module "sg_module"{
    sg_name = "sg_module_creation"
    source = "./sg_module"
}

module "ec2_module"{
    # count = 2
    ansible_user = local.ansible_user
    ansible_ssh_key = local.ansible_ssh_key
    ansible_file = local.ansible_file
    sg_id = module.sg_module.securityGp_Id
    ec2_name = "ec2-instance-ansible-testing"
    source = "./ec2_module"
}
