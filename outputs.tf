output "elasticsearch_https_endpoint" {
  description = "Elasticsearch resource HTTPs endpoint"
  value       = ec_deployment.deployment.elasticsearch[0].https_endpoint
}

output "elasticsearch_username" {
  description = "Auto-generated Elasticsearch username"
  value       = ec_deployment.deployment.elasticsearch_username
}

output "elasticsearch_password" {
  description = "Auto-generated Elasticsearch password"
  value       = ec_deployment.deployment.elasticsearch_password
  sensitive   = true
}

output "elasticsearch_cloud_id" {
  description = "Encoded Elasticsearch credentials to use in Beats or Logstash"
  value       = ec_deployment.deployment.elasticsearch[0].cloud_id
  sensitive   = true
}

output "deployment_id" {
  description = "Deployment identifier"
  value       = ec_deployment.deployment.id
}

output "kibana_https_endpoint" {
  description = "Kibana resource HTTPs endpoint"
  value       = var.enable_kibana ? ec_deployment.deployment.kibana[0].https_endpoint : null
}

output "apm_https_endpoint" {
  description = "APM resource HTTPs endpoint"
  value       = var.enable_apm ? ec_deployment.deployment.apm[0].https_endpoint : null
}

output "apm_secret_token" {
  description = "Generated APM secret_token"
  value       = var.enable_apm ? ec_deployment.deployment.apm_secret_token : null
  sensitive   = true
}
