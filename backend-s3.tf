terraform {
  backend "s3" {
    bucket = "s3-terr-final"
    key = "terraform/backend"
    region = "ap-southeast-1"
 }
}