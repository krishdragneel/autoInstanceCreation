#getting ami id
data "aws_ami" "os" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = var.ami_name
  }

  filter {
    name   = "virtualization-type"
    values = var.ami_virtualization_type
  }

  filter {
    name   = "root-device-type"
    values = var.root_device_type
  }


}

output "id" {

  value = data.aws_ami.os.id

}



#creating keypair
resource "aws_key_pair" "key_tf" {
  key_name   = var.key_name
  public_key = file("${path.module}/id_rsa.pub")
}


#creating security group
resource "aws_security_group" "securitygroup" {
  name        = var.securitygroupName
  description = "inbound traffic for instance"

  dynamic "ingress" {

    for_each = var.ingress_ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.securitygroupName
  }
}

#creating instance
resource "aws_instance" "web" {
  ami                    = data.aws_ami.os.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_tf.key_name
  vpc_security_group_ids = [aws_security_group.securitygroup.id]

  tags = {
    Name = var.instance_name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }


  provisioner "file" {
    content     = file("${path.module}/script.sh")
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }



}
