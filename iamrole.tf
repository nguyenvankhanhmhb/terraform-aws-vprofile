resource "aws_iam_role" "elasticbeanstalk_service_role" {
  name = "elasticbeanstalk-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth",
    "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
  ]
}

resource "aws_iam_instance_profile" "elasticbeanstalk_instance_profile" {
  name = "elasticbeanstalk-instance-profile"
  role = aws_iam_role.elasticbeanstalk_service_role.name
}
