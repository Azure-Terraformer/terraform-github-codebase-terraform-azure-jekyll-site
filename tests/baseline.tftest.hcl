run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "environment" {
  module {
    source = "./"
  }

  variables {
    repository = run.setup.repository_name
    branch     = "main"
    path       = "src"
    commit_user = {
      name  = var.github_username
      email = var.github_email
    }
  }

}
