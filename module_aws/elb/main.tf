resource "aws_lb" "alb" {
  name               = "${var.env}-${var.system}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.sg-elb}"]
  subnets            = var.subnets.*.id
  enable_deletion_protection = false

  tags = {
    Name = "${var.env}-${var.system}-alb"
    Cost = "${var.system}"
  }
}


resource "aws_lb_target_group" "tg1" {
  name     = "${var.env}-${var.system}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
}

resource "aws_lb_listener" "listener80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}


resource "aws_lb_target_group_attachment" "tg_attach" {
  count            = length(var.pub_instances)
  target_group_arn = aws_lb_target_group.tg1.arn
  target_id        = var.pub_instances[count.index].id
  port             = 80
}