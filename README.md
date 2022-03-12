# [Terraform GitHub provider examples](https://www.terraform.io/docs/providers/github/index.html)

This repository is an example of using Terraform provider for GitHub. It does:

* create two teams in organization (admins and users)
* invite people from variables into teams
* create personal repos for users
* enable branch protection so they cannot push to master without review
* add labels to user repos

## How to use

* Install Terraform (0.10 or newer)
* Copy terraform.tfvars.example to terraform.tfvars
* Fill values in terraform.tfvars. See description below
* Run `terraform init` and then `terraform apply`
* After that you can add new users and run apply again

## Parameters

### main.tf

* `provider "github"` - provider setup. You need to provide organization name and token
* `resource "github_team" "admins" and "users"` - create two teams in organization
* `resource "github_membership" "membership_for_admins and _users"` - define membership in organization
* `resource "github_team_membership" "admins_membership and _users"` - define membership in teams
* `resource "github_repository" "users_repos"` - create repos for users
* `resource "github_branch_protection" "users_repos"` - enable branch protection for user repos
* `resource "github_repository_collaborator" "users_repos"` - add users as collaborators to their repos
* `resource "github_issue_label" "users_repos"` - create labels from list and with count

### terraform.tfvars

You need to fill these variables:

* `gh_token` - token with admin rights to create repo, manage users in team and delete repos
* `gh_org` - name of organization
* `gh_admins` - list with admin users
* `gh_users` - list with usual users
* `gh_labels` - labels list
* `gh_task_count` - quantity of tasks in labels
