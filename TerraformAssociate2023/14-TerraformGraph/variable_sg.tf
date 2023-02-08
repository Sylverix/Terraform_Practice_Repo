variable "ingress_ports" {
    type = list
    default = [
        "443",
        "80",
        "22"
    ]
}