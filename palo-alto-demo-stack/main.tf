provider "aws" {
  region      = "${var.aws_region}"
}

/******************************************
  S3 Panos Bootstrap
******************************************/

module "s3-bootstrap-panos" {
  source  = "../../../modules/s3-bootstrap-panos"

  hostname         = "${var.firewall_hostname}"
  panorama-server  = "${var.panorama_primary}"
  panorama-server2 = "${var.panorama_secondary}"
  tplname          = "${var.tplname}"
  dgname           = "${var.dgname}"
  vm-auth-key      = "${var.vm-auth-key}"
}


/******************************************
  Provision FW EC2 instance
******************************************/

resource "aws_instance" "fw" {
  ami           = "${data.aws_ami.pan_instance_ami.id}"
  # ami           = "${var.fw_instance_ami[var.aws_region]}"
  instance_type = "${var.fw_instance_type[var.aws_region]}"
  key_name      = "${var.ssh_key_name}"

  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"

  ebs_optimized = true

  root_block_device {
    volume_type           = "gp2"
    delete_on_termination = true
  }

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.firewall_interface_management.id}"
  }

  network_interface {
    device_index         = 1
    network_interface_id = "${aws_network_interface.firewall_interface_untrust.id}"
  }

  network_interface {
    device_index         = 2
    network_interface_id = "${aws_network_interface.firewall_interface_trust.id}"
  }

  iam_instance_profile = "${module.s3-bootstrap-panos.instance_profile_name}"
  # user_data            = "${base64encode(join("", tolist(["vmseries-bootstrap-aws-s3bucket=", module.s3-bootstrap-panos.bucket_id])))}"
  user_data              = "type=dhcp-client\nhostname=PANW\nmgmt-interface-swap=enable"

  # tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}


/******************************************
  Provision Webserver EC2 instance
******************************************/

resource "aws_instance" "WebServer" {
  ami           = "${data.aws_ami.ubuntu-linux-2004.id}"
  instance_type = "${var.webserver_type}"
  key_name      = "${var.ssh_key_name}"
  user_data     = <<-EOF
                  #! /bin/bash
                  sudo apt-get update
                  sudo apt-get install -y apache2
                  sudo systemctl start apache2
                  sudo systemctl enable apache2
                  echo "<h1>Test AWS</h1>" | sudo tee /var/www/html/index.html
                  EOF
  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.webserver_interface_trust.id}"
  }
}

