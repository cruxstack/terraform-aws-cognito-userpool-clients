# Terraform Module: AWS Cognito Userpool Clients

This module creates and manages AWS Cognito User Pool Clients, allowing
fine-grained control over client configurations, UI customization, and secrets
management.

## Usage

```hcl
module "cognito_userpool_clients" {
  source  = "cruxstack/cognito-userpool-clients/aws"
  version = "x.x.x"

  userpool_id = "<cognito-userpool-id>"

  client_defaults = {
    callback_urls = ["https://example.com/auth/"]
  }

  clients = {
    internal_web_app = {}
    public_web_app   = {}
    mobile_app       = {}
    foobar_service   = {}
  }
}
```

## Inputs

This module uses the `cloudposse/label/null` module for naming and tagging
resources. As such, it also includes a `context.tf` file with additional
optional variables you can set. Refer to the [`cloudposse/label` documentation](https://registry.terraform.io/modules/cloudposse/label/null/latest)
for more details on these variables.

| Name               | Description                                                           | Type                 | Default | Required |
|--------------------|-----------------------------------------------------------------------|----------------------|---------|----------|
| `userpool_id`      | Cognito user pool ID.                                                 | `string`             | `null`  | No       |
| `client_defaults`  | Default configurations for each client.                               | `object({...})`      | `{}`    | No       |
| `clients`          | Map of client-specific configurations. The key is the client name.    | `map(object({...}))` | `{}`    | No       |
| `secrets_enabled`  | Toggle to create SecretsManager secrets for each client.              | `bool`               | `true`  | No       |
| `aws_kv_namespace` | The namespace or prefix for AWS SSM parameters and similar resources. | `string`             | `""`    | No       |

## Outputs

| Name                  | Description                                                                                          |
|-----------------------|------------------------------------------------------------------------------------------------------|
| `clients`             | Map of Cognito user pool clients created by the module.                                              |
| `client_secret_names` | Map of the names of Secrets Manager secrets for the Cognito user pool clients, keyed by client name. |


## Contributing

We welcome contributions to this project. For information on setting up a
development environment and how to make a contribution, see [CONTRIBUTING](./CONTRIBUTING.md)
documentation.
