resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.eks_cluster_prefix}-${var.eks_cluster_environment}-role"

  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json


}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}