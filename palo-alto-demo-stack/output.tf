output "Firewall_Management_URL" {
  value = "${join("", tolist(["https://", "${aws_eip.ManagementElasticIP.public_ip}"]))}"
}

output "Firewall_Untrust_URL" {
  value = "${join("", tolist(["https://", "${aws_eip.PublicElasticIP.public_ip}"]))}"
}

output "PublicServiceIP" {
  value = "${join("", tolist(["${aws_eip.PublicElasticIP.public_ip}"]))}"
}

output "Debug_Webserver" {
  value = "${join("", tolist(["http://", "${aws_eip.WebserverTrustTestElasticIP.public_ip}"]))}"
}