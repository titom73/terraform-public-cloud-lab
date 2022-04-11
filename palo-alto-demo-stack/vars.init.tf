variable "aws_region" {
  description = "Region to house the stack"
  default = "us-east-1"
}

variable "firewall_hostname" {
  description = "Firewall Hostname"
  default = "pan-fw"
}

# Panorama settings for Bootstraping
variable "panorama_primary" {
  description = "Primary Panorama server"
  default = "panorama1.as73.inetsix.net"
}

variable "panorama_secondary" {
  description = "Secondary Panorama server"
  default = "panorama2.as73.inetsix.net"
}

variable "tplname" {
    default = "My Firewall Template"
}

variable "dgname" {
    default = "My Firewalls"
}

variable "vm-auth-key" {
    default = "supersecretauthkey"
}

# Stack building

variable "stack_name" {
  description = "Name of the sack to build"
  default = "stack01"
}

variable "vpc_name" {
  description = "Name of the VPC to build"
  default = "vpc-stack01"
}

variable "vpc_cidr" {
  description = "Subnet to allocate to VPC"
  default = "10.1.0.0/16"
}

variable "public_cidr_block" {
  description = "Internal network for Public subnet"
  default = "10.1.1.0/24"
}

variable "firewall_untrust_ip" {
  description = "Untrust side IP for Palo Alto Firewall"
  default = "10.1.1.10"
}

variable "web_cidr_block" {
  description = "Network for internal resources"
  default = "10.1.2.0/24"
}

variable "firewall_trust_ip" {
  description = "Trust side IP for Palo Alto Firewall"
  default = "10.1.2.10"
}

variable "server_trust_ip" {
  description = "Trust side IP for Webserver"
  default = "10.1.2.20"
}

variable "mgt_cidr_block" {
  description = "Network for Management network"
  default = "10.1.3.0/24"
}

variable "firewall_management_ip" {
  description = "Management IP for Palo Alto Firewall"
  default = "10.1.3.10"
}
variable "ssh_key_name" {
  description = "SSH Key to use to allow remote access"
}

variable "webserver_type" {
  description = "Instance type to use for webserver"
  default = "t2.micro"
}

