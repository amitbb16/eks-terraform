locals {
  tags = {
    created-by = "ab=eks"
    env        = var.cluster_name
  }
}