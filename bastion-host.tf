resource "aws_instance" "vprofile-bastion" {
  ami           = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
#    key_name               = aws_key_pair.vprofilekey.key_name
  key_name                    = aws_key_pair.ec2-bastion-host-key-pair.key_name
  subnet_id                   = module.vpc.public_subnets[0]
#  key_name =aws_key_pair.test_
  count                       = var.instance_count
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.vprofile-bastion-sg.id]

  tags = {
    name    = "vpro-bastion host"
    PROJECT = "vprofile"
  }

  # File provisioner để upload script vào instance
  provisioner "file" {
    content = templatefile("templates/db-deploy.tmpl", {
      rds-endpoint = aws_db_instance.vprofile-rds.address
      dbuser       = var.dbuser
      dbpass       = var.dbpass
    })
    destination = "/tmp/vprofile-dbdeploy.sh"

    #    connection {
    #      user        = var.USERNAME
    #      private_key = file(var.PRIVATE_KEY_PATH)
    #      host        = self.public_ip //aws_instance.vprofile-bastion[count.index].public_ip  # Sử dụng count.index
    #    }
  }

  # Remote-exec để chạy script trên instance
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user = var.USERNAME
    #      private_key = file(var.PRIVATE_KEY_PATH)
    private_key = file(var.PRIVATE_KEY_PATH)
    host        = self.public_ip //aws_instance.vprofile-bastion[count.index].public_ip  # Sử dụng count.index
  }

  depends_on = [aws_db_instance.vprofile-rds] # Đảm bảo RDS đã sẵn sàng trước
}
