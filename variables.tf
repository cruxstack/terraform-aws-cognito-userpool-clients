# ================================================================== general ===

variable "userpool_id" {
  type        = string
  description = "Cognito user pool ID."
  default     = null
}

variable "client_defaults" {
  type = object({
    identity_providers            = optional(list(string), ["COGNITO"])
    generate_secret               = optional(bool, true)
    token_revocation_enabled      = optional(bool, true)
    prevent_user_existence_errors = optional(string, "ENABLED")

    cognito_auths = optional(object({
      admin_user_password_auth = optional(bool, false)
      custom_auth              = optional(bool, false)
      refresh_token_auth       = optional(bool, true)
      user_password_auth       = optional(bool, false)
      user_srp_auth            = optional(bool, true)
      }), {
      admin_user_password_auth = false
      custom_auth              = false
      refresh_token_auth       = true
      user_password_auth       = false
      user_srp_auth            = true
    })

    read_attributes                   = optional(list(string), [])
    read_attributes_builtin_included  = optional(bool, true)
    write_attributes                  = optional(list(string), [])
    write_attributes_builtin_included = optional(bool, true)

    allowed_oauth_flows                  = optional(list(string), ["code"])
    allowed_oauth_flows_user_pool_client = optional(bool, true)
    allowed_oauth_scopes                 = optional(list(string), ["email", "openid", "phone", "profile"])

    callback_urls = optional(list(string), [])
    logout_urls   = optional(list(string), [])

    token_validity = optional(object({
      access_token  = optional(number, 10)
      id_token      = optional(number, 60)
      refresh_token = optional(number, 4320)
      }), {
      access_token  = 10
      id_token      = 60
      refresh_token = 4320
    })

    token_validity_units = optional(object({
      access_token  = optional(string, "minutes")
      id_token      = optional(string, "minutes")
      refresh_token = optional(string, "minutes")
      }), {
      access_token  = "minutes"
      id_token      = "minutes"
      refresh_token = "minutes"
    })

    ui_customization = optional(object({
      enabled    = optional(bool, false)
      css_path   = optional(string, "")
      image_path = optional(string, "")
      }), {
      enabled    = false
      css_path   = ""
      image_path = ""
    })
  })
  description = "Default configurations for each client."
  default     = {}
}

variable "clients" {
  type = map(object({
    enabled = optional(bool, true)

    name                          = optional(string)
    pool_id                       = optional(string)
    identity_providers            = optional(list(string))
    generate_secret               = optional(bool)
    token_revocation_enabled      = optional(bool)
    prevent_user_existence_errors = optional(string)

    cognito_auths = optional(object({
      admin_user_password_auth = optional(bool)
      custom_auth              = optional(bool)
      refresh_token_auth       = optional(bool)
      user_password_auth       = optional(bool)
      user_srp_auth            = optional(bool)
    }), {})

    read_attributes                   = optional(list(string))
    read_attributes_builtin_included  = optional(bool)
    write_attributes                  = optional(list(string))
    write_attributes_builtin_included = optional(bool)

    allowed_oauth_flows                  = optional(list(string))
    allowed_oauth_flows_user_pool_client = optional(bool)
    allowed_oauth_scopes                 = optional(list(string))

    callback_urls = optional(list(string), [])
    logout_urls   = optional(list(string), [])

    token_validity = optional(object({
      access_token  = optional(number)
      id_token      = optional(number)
      refresh_token = optional(number)
    }), {})

    token_validity_units = optional(object({
      access_token  = optional(string)
      id_token      = optional(string)
      refresh_token = optional(string)
    }), {})

    ui_customization = optional(object({
      enabled    = optional(bool)
      css_path   = optional(string)
      image_path = optional(string)
    }), {})
  }))
  description = "Map of client-specific configurations. The key is the client name."
  default     = {}
}

variable "secrets_enabled" {
  type        = bool
  description = "Toggle to create SecretsManger secrets for each client."
  default     = true
}

# ------------------------------------------------------------------ context ---

variable "aws_kv_namespace" {
  type        = string
  description = "The namespace or prefix for AWS SSM parameters and similar resources."
  default     = ""
}
