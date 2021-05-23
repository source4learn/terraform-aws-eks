provider "aws" {
  region = "ap-south-1"
}
terraform {
  required_version = ">= 0.12.0"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.eks_cluster_prefix}-${var.eks_cluster_environment}"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  kubernetes_network_config {
    service_ipv4_cidr = var.eks_cluster_service_ipv4_cidr
  }

  timeouts {
    create = var.eks_cluster_create_timeout
    delete = var.eks_cluster_delete_timeout
    update = var.eks_cluster_update_timeout
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy,
    aws_cloudwatch_log_group.eks_cluster_cloudwatch_log_group
  ]

  tags = {
    Name        = "${var.eks_cluster_prefix}-${var.eks_cluster_environment}"
    Environment = var.eks_cluster_environment
  }
}

# data "tls_certificate" "eks_cluster_tls_certificate" {
#   url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
# }

# resource "aws_iam_openid_connect_provider" "eks_cluster_openid_connect_provider" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.eks_cluster_tls_certificate.certificates[0].sha1_fingerprint]
#   url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
# }

# data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks_cluster_openid_connect_provider.url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:kube-system:aws-node"]
#     }

#     principals {
#       identifiers = [aws_iam_openid_connect_provider.eks_cluster_openid_connect_provider.arn]
#       type        = "Federated"
#     }
#   }
# }