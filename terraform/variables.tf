variable "cluster_name" {
  type    = string
  default = "eks-for-devlopers"
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.28"
}
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "Defines the CIDR block used on Amazon VPC created for Amazon EKS."
  type        = string
  default     = "10.12.0.0/16"
}
