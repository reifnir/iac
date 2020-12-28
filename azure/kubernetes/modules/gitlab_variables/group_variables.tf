resource "gitlab_group_variable" "kubernetes_provider_info" {
  group         = data.gitlab_group.all_projects.id
  key           = "TF_VAR_kubernetes_provider_info_encoded"
  variable_type = "env_var"
  value         = base64encode(jsonencode(var.kubernetes_provider_info))
  protected     = false
  masked        = true
}

resource "gitlab_group_variable" "kube_config_admin" {
  group         = data.gitlab_group.all_projects.id
  key           = "TF_VAR_kube_config_admin"
  variable_type = "file"
  value         = var.kube_config_admin
  protected     = false
  masked        = false
}
