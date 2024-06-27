variable "ebs_size" {
  type        = list(number)
  description = "(Optional) Whether to enable volume encryption. Defaults to false."
}

variable "device_name" {
  description = "Additional tags for the VPC"
  type        = list(string)
}

variable "region" {
  description = "infra region"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_name" {
  description = "Additional tags for the VPC"
  type        = list(string)
}

variable "ebs_availability_zone" {
  description = "Additional tags for the VPC"
  type        = list(string)
}
