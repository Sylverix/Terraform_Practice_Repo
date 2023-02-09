module "ec2_module" {
  source = "../../modules/ec2"
}

module "sg_module" {
  source = "../../modules/sg"
}