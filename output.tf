output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_cluster_policy" {
  value = aws_iam_role_policy_attachment.eks_cluster_policy
}

output "eks_vpc_resource_controller_policy" {
  value = aws_iam_role_policy_attachment.eks_vpc_resource_controller_policy
}
