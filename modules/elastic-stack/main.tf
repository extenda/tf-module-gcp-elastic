data "google_secret_manager_secret_version" "elastic_secrets" {
  for_each = (var.project_id != "") ? toset(var.elastic_secrets) : []
  project  = var.project_id
  secret   = each.key
}

provider "elasticstack" {
  elasticsearch {
    username  = (var.project_id != "") ? data.google_secret_manager_secret_version.elastic_secrets["elasticsearch_username"].secret_data : var.elastic_secrets[0]
    password  = (var.project_id != "") ? data.google_secret_manager_secret_version.elastic_secrets["elasticsearch_password"].secret_data : var.elastic_secrets[1]
    endpoints = (var.project_id != "") ? ["${data.google_secret_manager_secret_version.elastic_secrets["elasticsearch_https_endpoint"].secret_data}"] : [var.elastic_secrets[2]]
  }
}

resource "elasticstack_elasticsearch_index" "index_config" {
  name     = var.index_name
  mappings = var.mappings

  dynamic "alias" {
    for_each = var.alias != null ? var.alias : []
    content {
      name           = alias.value.name
      filter         = lookup(alias.value, "filter", "")
      index_routing  = lookup(alias.value, "index_routing", "")
      is_hidden      = lookup(alias.value, "is_hidden", false)
      is_write_index = lookup(alias.value, "is_write_index", false)
      routing        = lookup(alias.value, "routing", "")
      search_routing = lookup(alias.value, "search_routing", "")
    }
  }

  // settings
  number_of_shards         = var.number_of_shards
  number_of_replicas       = var.number_of_replicas
  number_of_routing_shards = var.number_of_routing_shards
  routing_partition_size   = var.routing_partition_size
  refresh_interval         = var.refresh_interval
  search_idle_after        = var.search_idle_after
}
