provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "mongodb" {
  ami = "ami-0ce380b886769d3a8"
  instance_type = "t2.micro"
  security_groups = "${aws_security_group.db_security_group.id}"
  associate_public_ip_address = true
}

resource "aws_security_group" "db_security_group" {
  name = ""
  decription = ""

  tags {
    Name = "Project4-DB"
  }
}

resource "aws_security_group_rule" "mongodb_allow_all" {
  type = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.db_security_group.id}"
}

resource "aws_security_group_rule" "mongodb_ssh" {
  type = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.db_security_group.id}"
}

resource "aws_security_group_rule" "db_mongo" {
  type = "ingress"
  from_port       = 27019
  to_port         = 27019
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.db_security_group.id}"
}
