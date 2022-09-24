locals {
  common_tags = {
    Project   = "Safebot"
    CreatedAt = formatdate("YYYY-MM-DD", timestamp())
    ManagedBy = "Terraform"
    Owner     = "Lucas Bovolini"
  }
}