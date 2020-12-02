resource "gitlab_group_variable" "kubernetes_provider_info" {
   group     = data.gitlab_group.all_projects.id
   key       = "TF_VAR_kubernetes_provider_info_encoded"
   value     = base64encode(jsonencode(var.kubernetes_provider_info))
   protected = false
   masked    = true
}
