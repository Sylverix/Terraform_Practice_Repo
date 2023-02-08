variable "region-1" {
  type = string
  default = "us-east-1"
}

variable "access-key" {
  type = string
}

variable "secret-key" {
  type = string
}

variable "types-map" {
  type = map
  default = {
    us-east-1 = "t2.micro",
    us-west-1 = "t2.nano",
    us-south-1 = "t2.small"
  }
}

variable "types-list" {
  type = list
  default = [
    "t2.micro",
    "t2.nano",
    "t2.small"
  ]
}