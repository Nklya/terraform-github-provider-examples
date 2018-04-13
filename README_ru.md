# [Terraform GitHub provider examples](https://www.terraform.io/docs/providers/github/index.html)

[In English](README.md)

Пример использования Terraform с провайдеровм для GitHub. Он реализует:

* создает две команды (admins и users)
* приглашает пользователей из списков в организации
* создает персональные репозитории для пользователей
* включает защиту мастер бранча для запрета коммита без код ревью
* добавляет метки к репозиториям

## Как использовать

* Установите Terraform (0.10 or newer)
* Скопируйте terraform.tfvars.example to terraform.tfvars
* Заполните значения в terraform.tfvars. См. описание ниже
* Выполните `terraform init` а затем `terraform apply`

## Параметры

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

Нужно заполнить следующие переменные:

* `gh_token` - token with admin rights to create repo, manage users in team and delete repos
* `gh_org` - name of organization
* `gh_admins` - list with admin users
* `gh_users` - list with usual users
* `gh_labels` - labels list
* `gh_task_count` - quantity of tasks in labels
