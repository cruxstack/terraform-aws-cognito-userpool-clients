locals {
  enabled                 = module.this.enabled
  userpool_id             = var.userpool_id
  userpool_discovery_data = local.enabled ? jsondecode(data.http.cognito_user_pool[0].body) : null

  aws_kv_namespace = trim(coalesce(var.aws_kv_namespace, "cognito-userpool-clients/${local.userpool_id}"), "/")
  aws_region_name  = local.enabled ? data.aws_region.current[0].name : ""

  defaults = merge(var.client_defaults, { userpool_id = var.userpool_id })

  clients = {
    for client_name in(local.enabled ? keys(var.clients) : []) : client_name => merge(local.defaults, {
      name                          = var.clients[client_name].name
      userpool_id                   = local.defaults.userpool_id
      identity_providers            = coalesce(var.clients[client_name].identity_providers, local.defaults.identity_providers)
      generate_secret               = coalesce(var.clients[client_name].generate_secret, local.defaults.generate_secret)
      token_revocation_enabled      = coalesce(var.clients[client_name].token_revocation_enabled, local.defaults.token_revocation_enabled)
      prevent_user_existence_errors = coalesce(var.clients[client_name].prevent_user_existence_errors, local.defaults.prevent_user_existence_errors)

      cognito_auths = {
        admin_user_password_auth = coalesce(var.clients[client_name].cognito_auths.admin_user_password_auth, local.defaults.cognito_auths.admin_user_password_auth)
        custom_auth              = coalesce(var.clients[client_name].cognito_auths.custom_auth, local.defaults.cognito_auths.custom_auth)
        refresh_token_auth       = coalesce(var.clients[client_name].cognito_auths.refresh_token_auth, local.defaults.cognito_auths.refresh_token_auth)
        user_password_auth       = coalesce(var.clients[client_name].cognito_auths.user_password_auth, local.defaults.cognito_auths.user_password_auth)
        user_srp_auth            = coalesce(var.clients[client_name].cognito_auths.user_srp_auth, local.defaults.cognito_auths.user_srp_auth)
      }

      read_attributes = distinct(compact(flatten([
        coalesce(var.clients[client_name].read_attributes, local.defaults.read_attributes),
        coalesce(var.clients[client_name].read_attributes_builtin_included, local.defaults.read_attributes_builtin_included) == true ? local.builtin_read_attrs : []
      ])))

      write_attributes = distinct(compact(flatten([
        coalesce(var.clients[client_name].write_attributes, local.defaults.write_attributes),
        coalesce(var.clients[client_name].write_attributes_builtin_included, local.defaults.write_attributes_builtin_included) == true ? local.builtin_write_attrs : []
      ])))

      allowed_oauth_flows                  = coalesce(var.clients[client_name].allowed_oauth_flows, local.defaults.allowed_oauth_flows)
      allowed_oauth_flows_user_pool_client = coalesce(var.clients[client_name].allowed_oauth_flows_user_pool_client, local.defaults.allowed_oauth_flows_user_pool_client)
      allowed_oauth_scopes                 = coalesce(var.clients[client_name].allowed_oauth_scopes, local.defaults.allowed_oauth_scopes)

      callback_urls = try(coalescelist(var.clients[client_name].callback_urls, local.defaults.callback_urls), [])
      logout_urls   = try(coalescelist(var.clients[client_name].logout_urls, local.defaults.logout_urls), [])

      token_validity = {
        access_token  = coalesce(var.clients[client_name].token_validity.access_token, local.defaults.token_validity.access_token)
        id_token      = coalesce(var.clients[client_name].token_validity.id_token, local.defaults.token_validity.id_token)
        refresh_token = coalesce(var.clients[client_name].token_validity.refresh_token, local.defaults.token_validity.refresh_token)
      }

      token_validity_units = {
        access_token  = coalesce(var.clients[client_name].token_validity_units.access_token, local.defaults.token_validity_units.access_token)
        id_token      = coalesce(var.clients[client_name].token_validity_units.id_token, local.defaults.token_validity_units.id_token)
        refresh_token = coalesce(var.clients[client_name].token_validity_units.refresh_token, local.defaults.token_validity_units.refresh_token)
      }

      ui_customization = {
        enabled    = coalesce(var.clients[client_name].ui_customization.enabled, local.defaults.ui_customization.enabled)
        css_path   = try(coalesce(var.clients[client_name].ui_customization.css_path, local.defaults.ui_customization.css_path), "")
        image_path = try(coalesce(var.clients[client_name].ui_customization.image_path, local.defaults.ui_customization.image_path), "")
      }
    }) if var.clients[client_name].enabled
  }

  ui_customizations = {
    for client_name, client_opts in local.clients : client_name => merge({},
      client_opts.ui_customization
    ) if client_opts.ui_customization.enabled && (client_opts.ui_customization.css_path != "" || client_opts.ui_customization.image_path != "")
  }

  builtin_read_attrs = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo"
  ]

  builtin_write_attrs = [
    for x in local.builtin_read_attrs : x if !contains(["email_verified", "phone_number_verified"], x)
  ]


}

data "aws_region" "current" {
  count = local.enabled ? 1 : 0
}

# ================================================================== clients ===

module "client_label" {
  source   = "cloudposse/label/null"
  version  = "0.25.0"
  for_each = local.clients

  attributes = [each.key]
  context    = module.this.context
}

resource "aws_cognito_user_pool_client" "this" {
  for_each = local.clients

  name         = coalesce(each.value.name, module.client_label[each.key].id)
  user_pool_id = each.value.userpool_id

  explicit_auth_flows = compact([
    each.value.cognito_auths.admin_user_password_auth ? "ALLOW_ADMIN_USER_PASSWORD_AUTH" : "",
    each.value.cognito_auths.custom_auth ? "ALLOW_CUSTOM_AUTH" : "",
    each.value.cognito_auths.refresh_token_auth ? "ALLOW_REFRESH_TOKEN_AUTH" : "",
    each.value.cognito_auths.user_password_auth ? "ALLOW_USER_PASSWORD_AUTH" : "",
    each.value.cognito_auths.user_srp_auth ? "ALLOW_USER_SRP_AUTH" : "",
  ])

  enable_token_revocation       = each.value.token_revocation_enabled
  generate_secret               = each.value.generate_secret
  prevent_user_existence_errors = each.value.prevent_user_existence_errors

  read_attributes  = each.value.read_attributes
  write_attributes = each.value.write_attributes

  allowed_oauth_flows                  = each.value.allowed_oauth_flows
  allowed_oauth_flows_user_pool_client = each.value.allowed_oauth_flows_user_pool_client
  allowed_oauth_scopes                 = each.value.allowed_oauth_scopes

  callback_urls                = each.value.callback_urls
  logout_urls                  = each.value.logout_urls
  supported_identity_providers = each.value.identity_providers

  access_token_validity  = each.value.token_validity.access_token
  id_token_validity      = each.value.token_validity.id_token
  refresh_token_validity = each.value.token_validity.refresh_token

  token_validity_units {
    access_token  = each.value.token_validity_units.access_token
    id_token      = each.value.token_validity_units.id_token
    refresh_token = each.value.token_validity_units.refresh_token
  }
}

resource "aws_cognito_user_pool_ui_customization" "this" {
  for_each = local.ui_customizations

  user_pool_id = aws_cognito_user_pool_client.this[each.key].user_pool_id
  client_id    = aws_cognito_user_pool_client.this[each.key].id
  css          = each.value.css_path != "" ? file(each.value.css_path) : null
  image_file   = each.value.image_path != "" ? filebase64(each.value.image_path) : null
}

# ------------------------------------------------------------------ secrets ---

resource "aws_secretsmanager_secret" "clients" {
  for_each = var.secrets_enabled ? aws_cognito_user_pool_client.this : {}

  name                    = "${local.aws_kv_namespace}/clients/${each.key}"
  description             = "client secrets"
  kms_key_id              = ""
  recovery_window_in_days = 0 # not needed bc it is not a secret
  tags                    = module.this.tags
}

resource "aws_secretsmanager_secret_version" "clients" {
  for_each = var.secrets_enabled ? aws_cognito_user_pool_client.this : {}

  secret_id = aws_secretsmanager_secret.clients[each.key].id
  secret_string = jsonencode({
    user_pool_id       = local.userpool_id
    userpool_id        = local.userpool_id
    client_id          = each.value.id
    client_secret      = each.value.client_secret
    scopes             = each.value.allowed_oauth_scopes
    callback_urls      = each.value.callback_urls
    logout_urls        = each.value.logout_urls
    authorize_endpoint = local.userpool_discovery_data.authorization_endpoint
    token_endpoint     = local.userpool_discovery_data.token_endpoint
    userinfo_endpoint  = local.userpool_discovery_data.userinfo_endpoint
  })
}

# ================================================================== lookups ===

data "http" "cognito_user_pool" {
  count = local.enabled ? 1 : 0

  url = "https://cognito-idp.${local.aws_region_name}.amazonaws.com/${local.userpool_id}/.well-known/openid-configuration"
}
