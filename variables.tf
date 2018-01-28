variable "gh_token" {
  description = "GitHub token"
}

variable "gh_org" {
  description = "GitHub Organization"
}

variable "gh_admins" {
  type    = "list"
  default = []
}

variable "gh_users" {
  type    = "list"
  default = []
}

variable "gh_labels" {
  type    = "list"
  default = ["SomeTopic", "OtherTopic", "_⭐_"]
}

variable "gh_task_count" {
  description = "Tasks count"
  default     = 10
}
