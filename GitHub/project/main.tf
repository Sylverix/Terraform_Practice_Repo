resource "github_repository" "terraform-practice-repo" {
  name        = "Terraform_Practice_Repo"
  description = "This repository contains my Terraform work from various study/practice courses."

  visibility = local.visibility
}
