data "aws_region" "current" {}

locals {
  prefix = "${var.namespace}-${var.stage}-${var.name}"
  region = data.aws_region.current.name
}



resource "aws_lb" "this" {
  name               = "${var.name}-alb-${var.stage}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.ecs_alb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.name}-alb-${var.stage}"
    Environment = var.stage
  }
}
# ALB is deployed
resource "aws_alb_target_group" "this" {
  name        = "${var.name}-tg-${var.stage}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.name}-tg-${var.stage}"
    Environment = var.stage
  }

  depends_on = [aws_lb.this]
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

module "ecs_alb_sg" {
  source     = "cloudposse/security-group/aws"
  version    = "2.0.0-rc1"
  attributes = ["ecs-alb"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "HTTP"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow HTTP from everywhere"
    },
    {
      key         = "HTTPS"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow HTTPS from everywhere"
    }
  ]

  vpc_id = var.vpc_id
}
