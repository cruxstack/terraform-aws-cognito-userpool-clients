# Terraform Module: AWS Cognito Userpool Clients

_This repository is under development. See `dev` branch for latest progress._

## Usage

```hcl
module "cognito_userpool_clients" {
  source  = "cruxstack/cognito-userpool-clients/aws"
  version = "x.x.x"

  # TBD
}
```

## Inputs

This module uses the `cloudposse/label/null` module for naming and tagging
resources. As such, it also includes a `context.tf` file with additional
optional variables you can set. Refer to the [`cloudposse/label` documentation](https://registry.terraform.io/modules/cloudposse/label/null/latest)
for more details on these variables.

| Name          | Description | Type   | Default | Required |
|---------------|-------------|--------|---------|----------|
| `placeholder` | N/A         | string | `""`    | No       |

## Outputs

_This module does not currently provide any outputs._

## Contributing

We welcome contributions to this project. For information on setting up a
development environment and how to make a contribution, see [CONTRIBUTING](./CONTRIBUTING.md)
documentation.
