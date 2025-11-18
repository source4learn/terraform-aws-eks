# data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
#   statement {
#     effect = "Allow"
#     principals {
#       type        = "Service"
#       identifiers = ["eks.amazonaws.com"]
#     }
#     actions = [
#       "sts:AssumeRole",
#     ]
#   }
# }

# data "aws_iam_policy_document" "eks_cluster_elb_service_link_role_policy" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "ec2:DescribeAccountAttributes",
#       "ec2:DescribeInternetGateways",
#       "ec2:DescribeAddresses"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role" "eks_cluster_role" {
#   name = "${var.eks_cluster_prefix}-${var.eks_cluster_environment}-eks-cluster-role"
#   assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
# }

# resource "aws_iam_policy" "eks_cluster_elb_service_link_policy" {
#   name        = "${var.eks_cluster_prefix}-${var.eks_cluster_environment}-eks-cluster-elb-service-link-policy"
#   policy      = data.aws_iam_policy_document.eks_cluster_elb_service_link_role_policy.json
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks_cluster_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_service_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = aws_iam_role.eks_cluster_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.eks_cluster_role.name
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_elb_service_link_policy_attachment" {
#   policy_arn = aws_iam_policy.eks_cluster_elb_service_link_policy.arn
#   role       = aws_iam_role.eks_cluster_role.name
# }