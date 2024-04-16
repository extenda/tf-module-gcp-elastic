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

resource "elasticstack_elasticsearch_watch" "watch" {
  trigger     = var.trigger
  watch_id    = var.watch_id

  actions = var.actions
  active = var.active
  condition = var.condition
  input = var.input
  metadata = var.metadata
  throttle_period_in_millis = var.throttle_period_in_millis
  transform = var.transform
}
