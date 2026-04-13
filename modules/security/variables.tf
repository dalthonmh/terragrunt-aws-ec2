variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_environment" {
  type        = string
  description = "Application environment"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

# Added vpc_id variable so Security Group knows where to be created
variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create security group"
}
