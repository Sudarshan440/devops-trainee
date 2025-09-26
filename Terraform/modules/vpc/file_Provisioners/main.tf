provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "file_provisioner" {
  ami           = "ami-08982f1c5bf93d976"
  instance_type = "t2.micro"
  key_name      = "north-virgin"

  # Copy script to instance
  provisioner "file" {
    source      = "/workspaces/devops-trainee/Terraform/modules/vpc/file_Provisioners/infra.sh"       # local script
    destination = "/home/ec2-user/infra.sh" # remote path
  }

  # Run script on instance
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/infra.sh",
      "sudo /home/ec2-user/infra.sh"
    ]
  }

  # SSH connection details
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/workspaces/devops-trainee/Terraform/modules/vpc/file_Provisioners/north-virgin.pem")
    host        = self.public_ip
  }
}
