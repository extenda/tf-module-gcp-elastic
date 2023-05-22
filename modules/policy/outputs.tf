output "id" {
  description = "Internal identifier of the resource"
  value = {
    for k, v in elasticstack_elasticsearch_index_lifecycle.index_policy :
    k => v.id
  }
}
