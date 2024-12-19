#resource "aws_iam_role" "elasticbeanstalk_service_role" {
#  name = "elasticbeanstalk-service-role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect = "Allow"
#        Principal = {
#          Service = "elasticbeanstalk.amazonaws.com"
#        }
#        Action = "sts:AssumeRole"
#      }
#    ]
#  })
#
#  managed_policy_arns = [
#    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth",
#    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
#  ]
#}
#
#resource "aws_iam_instance_profile" "elasticbeanstalk_instance_profile" {
#  name = "elasticbeanstalk-instance-profile"
#  role = aws_iam_role.elasticbeanstalk_service_role.name
#}
resource "aws_iam_role" "role" {
  name = "test_role_new"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "subject_profile" {
  name = "test_role_new"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier",
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth",
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  ])

  role       = aws_iam_role.role.name
  policy_arn = each.value
}