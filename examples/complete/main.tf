locals {
  name = "tf-example-complete-${random_string.example_random_suffix.result}"
  tags = { tf_module = "cruxstack/cognito-userpool/aws", tf_module_example = "complete" }
}

# ================================================================== example ===

module "congito_userpool_clients" {
  source = "../../"

  userpool_id = module.congito_userpool.id

  client_defaults = {
    callback_urls = ["https://example.com/auth/"]
  }

  clients = {
    internal_web_app = {}
    public_web_app   = {}
    mobile_app       = {}
    foobar_service   = {}
  }

  context = module.example_label.context # not required
}

# ===================================================== supporting-resources ===

module "congito_userpool" {
  source  = "cruxstack/cognito-userpool/aws"
  version = "0.1.1"

  context = module.example_label.context
}

# ------------------------------------------------------------------- labels ---

module "example_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name = local.name
  tags = local.tags
}

resource "random_string" "example_random_suffix" {
  length  = 6
  special = false
  upper   = false
}
