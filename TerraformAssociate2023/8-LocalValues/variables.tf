variable "region-1" {
  type = string
  default = "us-east-1"
}

variable "keys" {
  type = map
  default = {
    access = "[ACCESS KEY HERE]",
    secret = "[SECRET KEY HERE]"
  }
}

locals {
  common_tags = {
    Name = "Local Values Test"
    Owner = "DevOps Team"
    Service = "Backend"
  }
}