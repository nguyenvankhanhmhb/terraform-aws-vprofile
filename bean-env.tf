resource "aws_elastic_beanstalk_environment" "Vpro-bean-prod" {
  name                = "Vpro-bean-prod"
  application         = aws_elastic_beanstalk_application.vprofile-prod.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.4.1 running Tomcat 10 Corretto 21" # There are multiple solution stacks such as Tomcat, Docker, Go, Node.JS etc. that we can find on Documentation. Our prefered is Tomcat
  cname_prefix        = "Vpro-bean-prod-domain"                                       # this will be the url

  setting {

    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = module.vpc.vpc_id

  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [module.vpc.private_subnets[0]], [module.vpc.private_subnets[1]], [module.vpc.private_subnets[2]]) # join is a functuon that can join lists into a string

  }


  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", [module.vpc.public_subnets[0]], [module.vpc.public_subnets[1]], [module.vpc.public_subnets[2]]) # this entire thing will be converted to a string
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.vprofilekey.key_name
  }
  # Setting Environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "environment"
    value     = "Prod"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "LOGGING_APPENDER"
    value     = "GRAYLOG"
  }

  # Setting for monitoring the health of EC2 instance





  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }




  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 3"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize" # defining maximum EC2 instance that can be launched
    value     = "8"
  }




  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.vprofile-prod-sg.id
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SecurityGroups"
    value     = aws_security_group.vprofile-bean-elb-sg.id
  }


  depends_on = [aws_security_group.vprofile-bean-elb-sg,
    aws_security_group.vprofile-prod-sg]

}
