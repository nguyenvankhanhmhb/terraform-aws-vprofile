# Tạo IAM Role
resource "aws_iam_role" "elasticbeanstalk_instance_role" {
  name = "aws-elasticbeanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Gán policy cho IAM Role
resource "aws_iam_role_policy_attachment" "elasticbeanstalk_instance_role_policy" {
  role       = aws_iam_role.elasticbeanstalk_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "elasticbeanstalk_instance_role_policy_s3" {
  role       = aws_iam_role.elasticbeanstalk_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Tạo IAM Instance Profile và gán IAM Role vào đó
resource "aws_iam_instance_profile" "elasticbeanstalk_instance_profile" {
  name = "aws-elasticbeanstalk-ec2-instance-profile"
  role = aws_iam_role.elasticbeanstalk_instance_role.name
}
