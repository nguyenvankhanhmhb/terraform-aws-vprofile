#resource "aws_launch_template" "vprofile_launch_template" {
#  name          = "vprofile-launch-template"
#  instance_type = "t2.micro"
#
#  network_interfaces {
#    associate_public_ip_address = false
#    subnet_id = module.vpc.private_subnets[0]
#
#    security_groups = [aws_security_group.vprofile-prod-sg.id]  # Đặt security_groups trong network_interfaces
#  }
#
#  iam_instance_profile {
#    name = aws_iam_instance_profile.elasticbeanstalk_instance_profile.name
#  }
#
#  key_name = aws_key_pair.vprofilekey.key_name
#}
