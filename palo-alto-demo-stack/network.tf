/******************************************
  Network AWS resources
******************************************/

/*** VPC ***/

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    "Application" = "${var.stack_name}"
    "Name" = "${var.vpc_name}"
  }
}

/*** Internet Gateway ***/

resource "aws_internet_gateway" "InternetGateway" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Application = "${var.stack_name}"
    Network =  "MGMT"
    Name = "${join("-", tolist([var.stack_name, "-InternetGateway"]))}"
  }
}

/*** Security Group ***/

resource "aws_security_group" "sgWideOpen" {
  name        = "sgWideOpen"
  description = "Wide open security group"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

/*** Routing Table ***/

resource "aws_route_table" "rtb_lab" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "rtb_lab"
  }
}

/*** Networks ***/

resource "aws_subnet" "untrust" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public_cidr_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  #map_public_ip_on_launch = false
  tags = {
    Application = "${var.stack_name}"
    Name = "${join("", tolist([var.stack_name, "unstrust-net"]))}"
  }
}

resource "aws_subnet" "trust" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.web_cidr_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  #map_public_ip_on_launch = false
  tags = {
        Application = "${var.stack_name}"
        Name = "${join("", tolist([var.stack_name, "trust-net"]))}"
  }
}

resource "aws_subnet" "management" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.mgt_cidr_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = false
  tags = {
        Application = "${var.stack_name}"
        Name = "${join("", tolist([var.stack_name, "mgt-net"]))}"
  }
}

/*** Route Table configuration ***/

resource "aws_route_table_association" "subnet_route_untrust" {
  subnet_id      = "${aws_subnet.untrust.id}"
  route_table_id = "${aws_route_table.rtb_lab.id}"
}

resource "aws_route_table_association" "subnet_route_trust" {
  subnet_id      = "${aws_subnet.trust.id}"
  route_table_id = "${aws_route_table.rtb_lab.id}"
}

resource "aws_route" "default_lab" {
  route_table_id               = "${aws_route_table.rtb_lab.id}"
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.InternetGateway.id}"
}


