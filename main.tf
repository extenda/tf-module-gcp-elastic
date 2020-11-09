data "google_secret_manager_secret_version" "elastic_secret" {
  provider = google-beta

  count   = (var.elastic_project_gcp_secret != "") ? 1 : 0
  project = var.elastic_project_gcp_secret
  secret  = var.elastic_apikey
}

provider "ec" {
  apikey = (var.elastic_project_gcp_secret != "") ? data.google_secret_manager_secret_version.elastic_secret[0].secret_data : var.elastic_apikey
}

resource "ec_deployment" "deployment" {
  name = var.name

  region                 = var.region
  version                = var.elastic_version
  deployment_template_id = var.deployment_id

  elasticsearch {
    topology {
      instance_configuration_id = var.elastic_insatnce_config_id
      size                      = var.elastic_size
      zone_count                = var.elastic_zone_count
    }

    config {
      plugins = var.plugins
    }
  }

  kibana {
    topology {
      instance_configuration_id = var.kibana_insatnce_config_id
      size                      = var.kibana_size
      zone_count                = var.kibana_zone_count
    }
  } 
}

locals {
  gcp_elastic_secrets = {
    elasticsearch_username       = ec_deployment.deployment.elasticsearch_username
    elasticsearch_https_endpoint = ec_deployment.deployment.elasticsearch[0].https_endpoint
    elasticsearch_password       = ec_deployment.deployment.elasticsearch_password
    kibana_https_endpoint        = ec_deployment.deployment.kibana[0].https_endpoint
  }
}


resource "google_secret_manager_secret" "elastic_secret_id" {
  provider = google-beta
  for_each = local.gcp_elastic_secrets

  secret_id = each.key
  project   = var.project_id

  labels = {
    terraform = ""
  }

  replication {
    automatic = true
  }

  depends_on = [ec_deployment.deployment]
}

resource "google_secret_manager_secret_version" "elastic_secret_value" {
  provider = google-beta
  for_each = local.gcp_elastic_secrets

  secret      = google_secret_manager_secret.elastic_secret_id[each.key].id
  secret_data = each.value

  depends_on = [ec_deployment.deployment]
}
