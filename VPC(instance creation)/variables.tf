#create varibale for bucket created
variable "vpcidr"{
    default = "10.0.0.0/16"
}

variable "project_tags" {
  type        = map(string)
  description = "Tags used for aws tutorial"
  default = {
    project = "aws-terraform-test"
  }
}

variable "public_ip" {
  type        = string
  description = "Your public IP goes here"
  default     = "0.0.0.0/0"
}

data "aws_availability_zones" "available" {}