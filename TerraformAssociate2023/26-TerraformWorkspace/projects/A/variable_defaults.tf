variable "default-region" {
  type    = string
  default = "us-east-1"
}

variable "keys" {
  type = map(any)
  default = {
    access = "[ACCESS KEY HERE]",
    secret = "[SECRET KEY HERE]"
  }
}
