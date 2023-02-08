variable "ingress_ports" {
  type = list(any)
  default = [
    "443",
    "80",
    "22"
  ]
}