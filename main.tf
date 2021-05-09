provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_version = ">= 0.12.0"
}

resource "aws_eks_cluster" "eks_cluster" {
  name      = "eks_cluster"
  role_arn  = aws_iam_role.eks_cluster_role.arn
  version   = "1.19"

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy
  ]
}
