output "settings" {
  description = "Cognito managed login branding settings"
  value       = var.settings
}

output "settings_json" {
  description = "JSON-encoded Cognito managed login branding settings"
  value       = jsonencode(var.settings)
}
