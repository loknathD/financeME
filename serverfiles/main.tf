
resource "aws_instance" "test_server" {
  ami           = "ami-0287a05f0ef0e9d9a"
  instance_type = "t2.micro"
  key_name      = "finance"
  vpc_security_group_ids = ["sg-0e7b3e09e354d5259"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./finance.pem")
     host = self.public_ip
}

provisinor "remote-exec" {
    inline = ["echo 'wait to start the instance'"]
}
tags = {
    name = "test-server"
}
provisinor "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory "
}
provisinor "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/financeME/serverfiles/finance-playbook.yml"
    }
}
