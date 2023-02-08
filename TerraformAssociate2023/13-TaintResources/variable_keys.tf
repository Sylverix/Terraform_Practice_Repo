variable "keys" {
  type = map(any)
  default = {
    access = "[ACCESS KEY HERE]",
    secret = "[SECRET KEY HERE]"
  }
}