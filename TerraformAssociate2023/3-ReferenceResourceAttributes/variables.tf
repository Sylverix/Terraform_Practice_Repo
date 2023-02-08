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

variable "https" {
  type = number
  default = 443
}

variable "http" {
  type = number
  default = 80
}

variable "ssh" {
  type = number
  default = 22
}