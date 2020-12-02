data "terraform_remote_state" "foundation" {
  backend = "http"

  config = {
    address = var.foundation_state_address
  }
}
