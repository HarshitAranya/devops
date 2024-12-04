#SSH from putty by using ppk | ssh-keygen -t rsa
resource "aws_key_pair" "KeyToConnect" {
  key_name = "KeyToConnect" #name should be there in txt file
  public_key = file("${var.pubkeypath}") #var.pubkeypath #file("pubkeyforsshputty.txt") not defigned in variable. it will be pars at the time of execution
}

# create vms
resource "aws_instance" "JenSlave" {
  ami                         = "ami-0cea098ed2ac54925"
  count                       = 1
  key_name                    = aws_key_pair.KeyToConnect.key_name #name should be there in txt file

  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.SG_VPCIP8000N8.id}"]
  subnet_id                   = aws_subnet.SUB-1-VPCIP8000N8.id
  # security_groups             = ["default"]
  associate_public_ip_address = true
  tags = {
    Name = "JenSlave"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    #private_key = data.template_file.private_sshkey.rendered
    private_key = file("forssh.pem")
    host        = self.public_ip
    timeout     = "1m"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 5",
      "hostnamectl set-hostname 'JenSlave'"
    ]
  }
}

resource "aws_instance" "JenMaster" {
  ami                         = "ami-0cea098ed2ac54925"
  count                       = 1
  key_name                    = aws_key_pair.KeyToConnect.key_name #name should be there in txt file
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.SG_VPCIP8000N8.id}"]
  subnet_id                   = aws_subnet.SUB-1-VPCIP8000N8.id
  # security_groups             = ["default"]
  associate_public_ip_address = true
  tags = {
    Name = "JenMaster"
  }

  user_data = <<-EOF
  #!/bin/bash
  hostnamectl set-hostname 'JenMaster'
  EOF
  #to git clone
  # sudo cat <<EOF_CAT1 > /root/.ssh/id_rsa
  # ${data.template_file.private_key.rendered}
  # EOF_CAT1
  # sleep 10
  # #JenMaster can connect
  # chmod 400 /root/.ssh/id_rsa
  # chmod 600 /home/ec2-user/.ssh/authorized_keys
  # sleep 40
  # cat <<EOF_CAT2 >> /home/ec2-user/.ssh/authorized_keys
  # ${data.template_file.public_key.rendered}
  # EOF_CAT2

  connection {
    type        = "ssh"
    user        = "ec2-user"
    #private_key = data.template_file.private_sshkey.rendered
    private_key = file("forssh.pem")
    host        = self.public_ip
    timeout     = "4m"
  }

  provisioner "file" {
    source      = "git_id_rsa.txt"
    destination = "/home/ec2-user/.ssh/id_rsa"
  }

  provisioner "file" {
    source      = "master.sh"
    destination = "/tmp/master.sh"
  }
  
  #Git Clone
  provisioner "remote-exec" {
    inline = [
      "sleep 15",
      "chmod 700 /home/ec2-user/.ssh/id_rsa",
      "chmod +x /tmp/master.sh",     
      "echo '${file("id_rsa_pub.txt")}' >> /home/ec2-user/.ssh/authorized_keys",
      "sleep 3",
      ". /tmp/master.sh"
    ]
  }
}