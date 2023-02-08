resource "aws_eip" "null-eip-demo" {
  vpc = true
  count = 3

  tags = {
    "Name" = "Null-EIP"
  }
}

resource "null_resource" "ip_check" {
    
    triggers = {
        latest_ips = join(", ", aws_eip.null-eip-demo[*].public_ip)
    }

  provisioner "local-exec" {
    command = "echo Latest IPs are ${null_resource.ip_check.triggers.latest_ips} > sample.txt"
  }
  
}