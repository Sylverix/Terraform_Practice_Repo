/*
resource "aws_eip" "null-eip-demo" {
  vpc = true
  depends_on = [null_resource.health_check]

  tags = {
    "Name" = "Null-EIP"
  }
}

resource "null_resource" "health_check" {
  
  provisioner "local-exec" {
    command = "curl https://google14536.com"
  }
  
}
*/