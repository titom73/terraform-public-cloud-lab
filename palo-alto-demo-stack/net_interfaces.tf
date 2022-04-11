resource "aws_network_interface" "firewall_interface_management" {
  subnet_id       = "${aws_subnet.management.id}"
  security_groups = ["${aws_security_group.sgWideOpen.id}"]
  source_dest_check = false
  private_ips_count = 1
  private_ips = ["${var.firewall_management_ip}"]
}

resource "aws_network_interface" "firewall_interface_untrust" {
  subnet_id       = "${aws_subnet.untrust.id}"
  security_groups = ["${aws_security_group.sgWideOpen.id}"]
  source_dest_check = false
  private_ips_count = 1
  private_ips = ["${var.firewall_untrust_ip}"]

}

resource "aws_network_interface" "firewall_interface_trust" {
  subnet_id       = "${aws_subnet.trust.id}"
  security_groups = ["${aws_security_group.sgWideOpen.id}"]
  source_dest_check = false
  private_ips_count = 1
  private_ips = ["${var.firewall_trust_ip}"]
}

resource "aws_network_interface" "webserver_interface_trust" {
  subnet_id       = "${aws_subnet.trust.id}"
  security_groups = ["${aws_security_group.sgWideOpen.id}"]
  source_dest_check = false
  private_ips_count = 1
  private_ips = ["${var.server_trust_ip}"]
}

/*** Elastic IP ***/

resource "aws_eip" "PublicElasticIP" {
  vpc   = true
  depends_on = [aws_vpc.main, aws_internet_gateway.InternetGateway]
}

resource "aws_eip" "ManagementElasticIP" {
  vpc   = true
  depends_on = [aws_vpc.main, aws_internet_gateway.InternetGateway]
}

resource "aws_eip" "WebserverTrustTestElasticIP" {
  vpc   = true
  depends_on = [aws_vpc.main, aws_internet_gateway.InternetGateway]
}

/*** Interface Attachment ***/

resource "aws_eip_association" "firewall_management_association" {
  network_interface_id   = "${aws_network_interface.firewall_interface_management.id}"
  allocation_id = "${aws_eip.ManagementElasticIP.id}"
}

resource "aws_eip_association" "firewall_untrust_association" {
  network_interface_id   = "${aws_network_interface.firewall_interface_untrust.id}"
  allocation_id = "${aws_eip.PublicElasticIP.id}"
}

# *** Only for testing purpose
# resource "aws_eip_association" "webserver_trust_association" {
#   network_interface_id   = "${aws_network_interface.webserver_interface_trust.id}"
#   allocation_id = "${aws_eip.WebserverTrustTestElasticIP.id}"
# }