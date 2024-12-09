# bean-app.tf

resource "aws_elastic_beanstalk_application" "vprofile-prod" {
  name        = "vprofile-prod"
  description = "Elastic Beanstalk Application for vprofile"
}
