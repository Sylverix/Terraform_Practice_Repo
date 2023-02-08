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

variable "instance-types" {
  type = list
  default = [
    "t2.micro",
    "t2.large"
  ]
}

variable "istest" {
  type = bool
}