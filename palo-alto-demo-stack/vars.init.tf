variable "bootstrap_region" {
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