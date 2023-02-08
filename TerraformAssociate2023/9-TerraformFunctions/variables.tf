variable "default-region" {
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

variable "ami" {
  type = map
  default = {
    us-east-1 = "ami-0b5eea76982371e91",
    us-east-2 = "ami-0a606d8395a538502",
    us-west-1 = "ami-00d8a762cb0c50254",
    us-west-2 = "ami-0ceecbb0f30a902a6",
    ap-south-1 = "ami-0cca134ec43cf708f",
    ap-northeast-1 = "ami-0bba69335379e17f8",
    ap-northeast-2 = "ami-035233c9da2fabf52",
    ap-northeast-3 = "ami-009a12cc1b7171e6e",
    ap-southeast-1 = "ami-005835d578c62050d",
    ap-southeast-2 = "ami-051a81c2bd3e755db",
    ca-central-1 = "ami-06c3426233c180fef",
    eu-central-1 = "ami-0a261c0e5f51090b1",
    eu-west-1 = "ami-0fe0b2cf0e1f25c8a",
    eu-west-2 = "ami-084e8c05825742534",
    eu-west-3 = "ami-0cc814d99c59f3789",
    eu-north-1 = "ami-07bdb714a483cb3bc",
    sa-east-1 = "ami-0b0d54b52c62864d6"
  }
}

variable "tags" {
  type = list
  default = [
    "first-ec2",
    "second-ec2"
  ]
}

locals {
  time_created = formatdate("EEE, MMM-DD-YYYY hh:mm ZZZ", timestamp())
}