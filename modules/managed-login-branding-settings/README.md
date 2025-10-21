# Managed Login Branding Settings

Provides settings for Cognito Branded UI. The default values are the actual
default values. This allow easy viewing all avalilable settings and their
defaults. Additionally, it allow for easily overriding a subset of the values.

## Usage

```hcl
module "branding_settings" {
  source = "./modules/managed-login-branding-settings"

  settings = {
    components = {
      primaryButton = {
        lightMode = {
          defaults = {
            backgroundColor = "ff0000ff"
          }
        }
      }
    }
  }
}

resource "aws_cognito_managed_login_branding" "example" {
  user_pool_id = aws_cognito_user_pool.example.id
  client_id    = aws_cognito_user_pool_client.example.id
  settings     = module.branding_settings.settings_json
}
```

## Inputs


| Name       | Description                             | Type            | Default | Required |
|------------|-----------------------------------------|-----------------|---------|----------|
| `settings` | Cognito managed login branding settings | `object({...})` | `{}`    | No       |

## Outputs

| Name            | Description                                          |
|-----------------|------------------------------------------------------|
| `settings`      | Cognito managed login branding settings              |
| `settings_json` | JSON-encoded Cognito managed login branding settings |

