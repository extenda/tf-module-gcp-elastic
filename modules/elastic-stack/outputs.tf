output "settings" {
  description = "All raw settings fetched from the cluster"
  value       = jsondecode(elasticstack_elasticsearch_index.index_config.settings_raw)
}

output "id" {
  description = "Internal identifier of the resource"
  value       = elasticstack_elasticsearch_index.index_config.id
}
