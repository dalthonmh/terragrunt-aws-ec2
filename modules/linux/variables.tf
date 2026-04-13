########################################
## Virtual Machine Module - Variables ##
########################################
variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_environment" {
  type        = string
  description = "Application environment"
}

# Virtual Machine Variables
variable "linux_instance_type" {
  type        = string
  description = "EC2 instance type for Linux Server"
  default     = "t3.small"
}

variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}

variable "linux_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Linux Server"
}

variable "linux_data_volume_size" {
  type        = number
  description = "Volumen size of data volumen of Linux Server"
}

variable "linux_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Linux Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp3"
}

variable "linux_data_volume_type" {
  type        = string
  description = "Volumen type of data volumen of Linux Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp3"
}

# Variables required for connection
variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to launch in"
}

variable "security_group_id" {
  type        = string
  description = "The Security Group ID"
}

# AMI Variables
variable "ami_owners" {
  type        = list(string)
  description = "Owners ID for debian, official and localstack"
  default     = ["136693071363"]
}

variable "ami_filter_name" {
  type        = string
  description = "Name filter for debian AMI"
  default     = "debian-13-amd64-*"
}
