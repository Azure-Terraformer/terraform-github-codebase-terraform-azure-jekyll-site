locals {
  terraform_files = [
    "main.tf",
    "outputs.tf",
    "storage.tf",
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

resource "github_repository_file" "terraform_tfvars" {

  repository = var.repository
  branch     = var.branch
  file       = "${var.path}/terraform.tfvars"
  content = templatefile("${path.module}/files/src/terraform/terraform.tfvars.t4",
    {
      location = var.location
    }
  )
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true

}
