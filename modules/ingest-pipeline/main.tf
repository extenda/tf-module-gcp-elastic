data "google_secret_manager_secret_version" "elastic_secrets" {
  for_each = (var.project_id != "") ? toset(var.elastic_secrets) : []
  project  = var.project_id
  secret   = each.key
}

provider "elasticstack" {
  elasticsearch {
    username  = (var.project_id != "") ? data.google_secret_manager_secret_version.elastic_secrets[var.elastic_secrets[0]].secret_data : var.elastic_secrets[0]
    password  = (var.project_id != "") ? data.google_secret_manager_secret_version.elastic_secrets[var.elastic_secrets[1]].secret_data : var.elastic_secrets[1]
    endpoints = (var.project_id != "") ? ["${data.google_secret_manager_secret_version.elastic_secrets[var.elastic_secrets[2]].secret_data}"] : [var.elastic_secrets[2]]
  }
}

resource "elasticstack_elasticsearch_ingest_pipeline" "pipeline" {
  name        = var.pipeline_name
  description = var.description
  processors  = var.processors
  on_failure  = var.on_failure
  metadata    = var.metadata
}
