module "webserver" {

  source = "./root_directory"

  region                  = var.region
  access_key              = var.access_key
  secret_key              = var.secret_key
  ami_owners              = var.ami_owners
  ami_name                = var.ami_name
  ami_virtualization_type = var.ami_virtualization_type
  root_device_type        = var.root_device_type
  key_name                = var.key_name
  securitygroupName       = var.securitygroupName
  instance_type           = var.instance_type
  instance_name           = var.instance_name
  ingress_ports           = var.ingress_ports

}


# output "amiid" {
#   value = module.webserver.id
# }