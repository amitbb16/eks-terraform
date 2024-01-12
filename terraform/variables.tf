variable "cluster_name" {
  type    = string
  default = "eks-for-dev"
}

variable "cluster_version" {
  description = "EKS cluster version."
  type        = string
  default     = "1.28"
}