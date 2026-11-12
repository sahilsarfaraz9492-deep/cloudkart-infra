output "server_public_ip" {
  value = module.ec2.public_ip
}

output "ecr_urls" {
  value = [for r in aws_ecr_repository.repos : r.repository_url]
}
