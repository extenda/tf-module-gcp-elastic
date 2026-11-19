output "id" {
  description = "Internal identifier of the resource"
  value       = elasticstack_elasticsearch_ingest_pipeline.pipeline.id
}

output "name" {
  description = "Name of the ingest pipeline. Pass it as default_pipeline to the index module"
  value       = elasticstack_elasticsearch_ingest_pipeline.pipeline.name
}
