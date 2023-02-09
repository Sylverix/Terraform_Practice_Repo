provider "aws" {
  region = var.region-1
  access_key = var.access-key
  secret_key = var.secret-key
}

# Create a new load balancer
resource "aws_elb" "terraform-elb" {
  name               = var.elb-name
  availability_zones = var.az

  listener {
    instance_port     = 8000
    instance_protocol = var.protocol-type
    lb_port           = 80
    lb_protocol       = var.protocol-type
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = var.bool-true
  idle_timeout                = var.timeout
  connection_draining         = var.bool-true
  connection_draining_timeout = var.timeout

  tags = {
    Name = var.elb-name
  }
}