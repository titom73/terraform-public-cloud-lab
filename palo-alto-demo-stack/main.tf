provider "aws" {
  region      = "${var.bootstrap_region}"
}

module "s3-bootstrap-panos" {
  source  = "../../modules/s3-bootstrap-panos"

  hostname         = "${var.firewall_hostname}"
  panorama-server  = "${var.panorama_primary}"
  panorama-server2 = "${var.panorama_secondary}"
  tplname          = "${var.tplname}"
  dgname           = "${var.dgname}"
  vm-auth-key      = "${var.vm-auth-key}"
}