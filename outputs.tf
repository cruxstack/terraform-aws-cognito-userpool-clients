output "userpool_id" {
  value = local.userpool_id
}

output "userpool_discovery_data" {
  value = local.userpool_discovery_data
}

output "clients" {
  description = "Map of Cognito user pool clients created by the module."
  value       = aws_cognito_user_pool_client.this
}

output "client_secret_names" {
  description = "Map of the names of Secrets Manager secrets for the Cognito user pool clients, keyed by client name."
  value = {
    for client_name, client_secret in aws_secretsmanager_secret.clients : client_name => client_secret.name
  }
}
