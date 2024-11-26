variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "AMIs" {
  type = map(any)
  default = {
    ap-southeast-2 = "ami-0146fc9ad419e2cfd"
    ap-northeast-1 = "ami-023ff3d4ab11b2525"
    ap-southeast-1 = "ami-0f935a2ecd3a7bd5c"
  }
}
variable "PRIVATE_KEY_PATH" {
  default = "vprofilekey"

}
variable "PUBLIC_KEY_PATH" {
  default = "vprofilekey.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "106.221.149.15/32"
}

variable "rmquser" {
  default = "rabbit"

}

variable "rmqpass" {
  default = "Pass@780956283"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "vprofile-VPC"
}

variable "ZONE1" {
  default = "ap-southeast-1a"
}
variable "ZONE2" {
  default = "ap-southeast-1b"
}
variable "ZONE3" {
  default = "ap-southeast-1c"
}

variable "VpcCIDER" {
  default = "172.21.0.0/16"
}

variable "PubSub1CIDER" {
  default = "172.21.1.0/24"

}

variable "PubSub2CIDER" {
  default = "172.21.7.0/24"

}

variable "PubSub3CIDER" {
  default = "172.21.3.0/24"

}

variable "PrivSub1CIDER" {
  default = "172.21.4.0/24"

}

variable "PrivSub2CIDER" {
  default = "172.21.5.0/24"
}

variable "PrivSub3CIDER" {
  default = "172.21.6.0/24"

}