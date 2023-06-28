variable "region" {

  type = string

}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string

}

variable "ami_owners" {

  type = list(string)

}

variable "ami_name" {

  type = list(string)

}

variable "ami_virtualization_type" {
  type = list(string)

}

variable "root_device_type" {
  type = list(string)
}

variable "key_name" {
  type = string

}

variable "securitygroupName" {
  type = string

}

variable "instance_type" {
  type = string

}

variable "instance_name" {

  type = string

}

variable "ingress_ports" {
  type = list(number)

}
