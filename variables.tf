variable "repository" {
  type        = string
  description = "The name of the GitHub repository where the GitHub source code and GitHub Actions workflow YAML file will be created."
}
variable "branch" {
  type        = string
  description = "The branch of the GitHub repository where the workflow YAML file will be committed."
}
variable "location" {
  type        = string
  description = "The Azure Region to provision the Web Site into"
}
variable "path" {
  type        = string
  description = <<DESCRIPTION
The file system path within the repository where the Terraform Source Code will be stored.

This path determines the directory structure in the repository, organizing configuration files for better manageability.
DESCRIPTION
}
variable "commit_user" {
  type = object({
    name  = string
    email = string
  })
  description = <<DESCRIPTION
The GitHub identity used to commit the workflow YAML file to the repository.

This includes:
- **name**: The name of the user committing the workflow file.
- **email**: The email address of the user committing the workflow file.

Ensure that the provided Git identity has the necessary permissions to push changes to the specified repository and branch.
DESCRIPTION
}
variable "environments" {
  type        = map(string)
  description = <<DESCRIPTION
Configuration for each of the environments for this application.

Each entry in the map represents an environment and its associated Git branch:
- **Key**: The name of the environment (e.g., "dev", "test", "prod").
- **Value**: The name of the Git branch corresponding to the environment (e.g., "develop", "release", "main").

This mapping allows the module to manage environment-specific configurations and deployments by linking each environment to its designated Git branch. It ensures that deployments are consistent and correctly targeted based on the branch associated with each environment.

**Example:**
```hcl
environments = {
  dev  = "develop"
  test = "release"
  prod = "main"
}
DESCRIPTION
}
