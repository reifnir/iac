data "terraform_remote_state" "foundation" {
  backend = "http"

  config = {
    address = var.foundation_state_address
  }
}

data "terraform_remote_state" "kubernetes" {
  backend = "http"

  config = {
    address = var.kubernetes_state_address
  }
}
