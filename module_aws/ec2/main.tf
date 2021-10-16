


resource "aws_security_group" "sg-ec2" {
  name        = "tf-sample-module-sg-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.sg-elb.id]
    cidr_blocks = [var.myip]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.myip]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-${var.system}-sg-http"
    Cost = "${var.system}"
  }
}

resource "aws_security_group" "sg-elb" {
  name        = "tf-sample-module-sg-elb"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.myip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-${var.system}-sg-http"
    Cost = "${var.system}"
  }
}

resource "aws_instance" "ec2" {
  count         = var.instance_cnt
  ami           = var.ami
  instance_type = var.type
  key_name      = var.key_name
  vpc_security_group_ids = [
    "${aws_security_group.sg-ec2.id}"
  ]
  subnet_id                   = element(var.subnets.*.id, count.index % length(var.subnets))
  associate_public_ip_address = "true"
  tags = {
    Name = "${var.env}-${var.system}-web"
    Cost = "${var.system}"
  }
}



