# Define provider
provider "github" {
  token        = "${var.gh_token}"
  organization = "${var.gh_org}"
}

# Define teams
resource "github_team" "admins" {
  name        = "Admins"
  description = "Admins team"
  privacy     = "closed"
}

resource "github_team" "users" {
  name        = "Users"
  description = "Users team"
  privacy     = "closed"
}

# Add users to the organization
resource "github_membership" "membership_for_admins" {
  count    = "${length(var.gh_admins)}"
  username = "${var.gh_admins[count.index]}"
  role     = "admin"
}

resource "github_membership" "membership_for_users" {
  count    = "${length(var.gh_users)}"
  username = "${var.gh_users[count.index]}"
  role     = "member"
}

# Add users to teams
resource "github_team_membership" "admins_membership" {
  team_id  = "${github_team.admins.id}"
  count    = "${length(var.gh_admins)}"
  username = "${var.gh_admins[count.index]}"
  role     = "maintainer"
}

resource "github_team_membership" "users_membership" {
  team_id  = "${github_team.users.id}"
  count    = "${length(var.gh_users)}"
  username = "${var.gh_users[count.index]}"
  role     = "member"
}

# Create repos
resource "github_repository" "users_repos" {
  count            = "${length(var.gh_users)}"
  name             = "${var.gh_users[count.index]}_repo"
  description      = "${var.gh_users[count.index]} repository"
  auto_init        = "true"
  license_template = "mit"
  depends_on       = ["github_team_membership.users_membership"]
}

# Set protection
resource "github_branch_protection" "users_repos" {
  count                         = "${length(var.gh_users)}"
  repository                    = "${var.gh_users[count.index]}_repo"
  branch                        = "master"
  enforce_admins                = "false"
  required_pull_request_reviews = {}
  depends_on                    = ["github_repository.users_repos"]
}

# Add a collaborator to a repository
resource "github_repository_collaborator" "users_repos" {
  count      = "${length(var.gh_users)}"
  repository = "${var.gh_users[count.index]}_repo"
  username   = "${var.gh_users[count.index]}"
  permission = "push"
  depends_on = ["github_repository.users_repos"]
}

# Create labels
resource "github_issue_label" "users_repos" {
  count      = "${length(var.gh_users) * length(var.gh_labels) * var.gh_labels_enable}"
  repository = "${var.gh_users[count.index / length(var.gh_labels)]}_repo"
  name       = "${var.gh_labels[(count.index) % length(var.gh_labels)]}"
  color      = "${var.gh_color_labels}"
  depends_on = ["github_repository.users_repos"]
}

resource "github_issue_label" "users_repost" {
  count      = "${length(var.gh_users) * var.gh_task_count  * var.gh_labels_enable}"
  repository = "${var.gh_users[count.index / var.gh_task_count]}_repo"
  name       = "Task-${(count.index) % var.gh_task_count + 1}"
  color      = "${var.gh_color_tasks}"
  depends_on = ["github_repository.users_repos"]
}
