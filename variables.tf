
variable "subnet_ids" {
  description = "List of VPC Subnets to be set in EKS Cluster"
  type        = list(any)
  default     = ["subnet-d12321b9", "subnet-4a245706", "subnet-38299343"]
}
