###################################################################################
# Output Configuration
###################################################################################

output "repository_urls" {
  description = "The URLs of the created repositories"
  value       = { for key, ecr_repo in aws_ecr_repository.ecr : key => ecr_repo.repository_url }
}

output "repository_names" {
  description = "The names of the repositories"
  value       = { for key, _ in aws_ecr_repository.ecr : key => aws_ecr_repository.ecr[key].name }
}