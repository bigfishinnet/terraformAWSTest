
# Create the EC2 Instance

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  subnet_id = "${aws_subnet.stephen-subnetprivate.id}"
  instance_type = "t2.micro"
associate_public_ip_address = true

   tags {
     Name = "stephen-apache-ec2"
     }
        provisioner "remote-exec" {
    inline = [
      "sudo apt-get update && sudo apt-get install apache2 && sudo service apache2 start"
     }
}
}