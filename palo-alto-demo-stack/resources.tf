/******************************************
  Palo Alto Resources
******************************************/

data "aws_ami" "pan_instance_ami" {
  most_recent = true
  owners      = ["679593333241"] # Palo Alto
  filter {
    name = "name"
    values = ["PA-VM-AWS-10.2.0*"]
  }
}

variable "fw_instance_type" {
  type = map
  description = "VM Type per region"
  default = {
      us-east-1      =   "m5.2xlarge",
    }
}

/******************************************
  Availability Zone
******************************************/

data "aws_availability_zones" "available" {}


/******************************************
  AMI for Ubuntu Linux
******************************************/

# Get latest Ubuntu Linux Bionic Beaver 18.04 AMI
data "aws_ami" "ubuntu-linux-1804" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get latest Ubuntu Linux Focal Fossa 20.04 AMI
data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}