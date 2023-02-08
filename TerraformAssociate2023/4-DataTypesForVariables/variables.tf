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

variable "elb-name" {
  type = string
  default = "foobar-terraform-elb"
}

variable "az" {
  type = list
  default = [
    "us-east-1a"
  ]
}

variable "timeout" {
  type = number
  default = 400
}

variable "bool-true" {
  type = bool
  default = true
}

variable "protocol-type" {
  type = string
  default = "http"
}