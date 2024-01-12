variable "cluster_name" {
  type    = string
  default = "eks-for-dev"
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
  default     = "ap-south-1"
}
