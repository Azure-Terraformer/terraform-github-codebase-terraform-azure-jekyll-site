locals {
  jekyll_static_files = [
    "sites/www/_posts/2025-01-20-welcome-to-jekyll.md",
    "sites/www/_config.yml",
    "sites/www/404.html",
    "sites/www/about.md",
    "sites/www/Gemfile",
    "sites/www/index.md"
  ]
}

resource "github_repository_file" "bulk" {

  for_each = toset(local.jekyll_static_files)

  repository          = var.repository
  branch              = var.branch
  file                = each.key
  content             = file("${path.module}/files/${each.key}")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
