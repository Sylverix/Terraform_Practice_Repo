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

variable "elb-names" {
  type = list
  default = [
    "dev-elb",
    "stage-elb",
    "prod-elb"
  ]
}