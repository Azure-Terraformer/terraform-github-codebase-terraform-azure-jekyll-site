locals {
  merge_storage_yaml = file("${path.module}/files/.github/workflows/atat-publish-jekyll-static-website.yaml.t4")
}

resource "github_repository_file" "push_deploy_storage" {

  for_each = var.environments

  repository          = var.repository
  branch              = var.branch
  file                = ".github/workflows/atat-publish-jekyll-static-website-${each.key}.yaml"
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

  content = templatestring(local.merge_storage_yaml,
    {
      working_directory = "sites/www"
      environment_name  = each.key
    }
  )

}
