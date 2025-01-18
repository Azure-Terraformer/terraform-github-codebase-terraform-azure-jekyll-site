locals {
  terraform_files = [
    "main.tf",
    "outputs.tf",
    "storage.tf",
    "terraform.tfvars",
    "variables.tf",
    "versions.tf"
  ]
}

resource "github_repository_file" "terraform_folder" {

  for_each = toset(local.terraform_files)

  repository          = var.repository
  branch              = var.branch
  file                = "${var.path}/${each.key}"
  content             = file("${path.module}/files/src/terraform/${each.key}.t4")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
