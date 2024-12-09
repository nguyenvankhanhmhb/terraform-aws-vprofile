#resource "aws_autoscaling_group" "vprofile_asg" {
#  desired_capacity     = 2
#  max_size             = 3
#  min_size             = 1
#
#  # Sử dụng launch_template trong block launch_template
#  launch_template {
#    id      = aws_launch_template.vprofile_launch_template.id
#    version = "$Latest"  # Hoặc bạn có thể thay bằng version cụ thể nếu cần
#  }
#
#  vpc_zone_identifier = [module.vpc.private_subnets[0]]  # Tham chiếu tới các subnet VPC của bạn
#}
