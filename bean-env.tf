resource "aws_elastic_beanstalk_environment" "vprofile-bean-prod" {
  depends_on = [
    aws_security_group.vprofile-bean-elb-sg,
    aws_security_group.vprofile-prod-sg,
    aws_elastic_beanstalk_application.vprofile-prod,
#    aws_key_pair.vprofilekey,
aws_key_pair.ec2-bastion-host-key-pair,
#    aws_key_pair.id_ed25519,
    aws_iam_role.role,
    aws_iam_instance_profile.subject_profile
  ]

  name                = "vprofile-bean-prod"
  application         = aws_elastic_beanstalk_application.vprofile-prod.name
  solution_stack_name = "64bit Amazon Linux 2023 v5.4.1 running Tomcat 10 Corretto 21" // "64bit Amazon Linux 2023 v5.4.1 running Tomcat 10 Corretto 21"


  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = "80"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "false"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value = join(",", [module.vpc.public_subnets[0]], [module.vpc.public_subnets[1]], [
    module.vpc.public_subnets[2]])
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = "/"
  }

  #  setting {
  #    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  #    name      = "RollingUpdateEnabled"
  #    value     = "true"
  #  }
  #
  #  setting {
  #    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  #    name      = "MinInstancesInService"
  #    value     = "0"
  #  }
  #
  #  setting {
  #    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  #    name      = "RollingUpdateType"
  #    value     = "Time"
  #  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  #  setting {
  #    namespace = "aws:ec2:vpc"
  #    name      = "ELBScheme"
  #    value     = "SingleInstance"
  #  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "DisableIMDSv1"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.subject_profile.name
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
#    value = aws_key_pair.vprofilekey.key_name
#    value = aws_key_pair.id_2
    value     = aws_key_pair.ec2-bastion-host-key-pair.key_name //aws_key_pair.vprofilekey.key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "RootVolumeType"
    value     = "gp3"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.role.name
  }
  # Không sử dụng LaunchTemplate ở đây nữa
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "EnableSpot"
    value     = "true"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "8"
  }

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

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "StickinessEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "StickinessEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Fixed"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "1"
  }
  #
  #  setting {
  #    namespace = "aws:elb:loadbalancer"
  #    name      = "CrossZone"
  #    value     = "true"
  #  }

  #  setting {
  #    namespace = "aws:elb:listener"
  #    name      = "ListenerProtocol"
  #    value     = "HTTP"
  #  }
  #
  #  setting {
  #    namespace = "aws:elb:listener"
  #    name      = "InstancePort"
  #    value     = "80"
  #  }
  #
  #  setting {
  #    namespace = "aws:elb:listener"
  #    name      = "ListenerEnabled"
  #    value     = "true"
  #  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.vprofile-bean-elb-sg.id
  }

}

