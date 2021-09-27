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
    autoscale = var.autoscale

    dynamic topology {
      for_each = var.topology
      content {
        id               = lookup(topology.value, "id", null)
        size             = lookup(topology.value, "size", null)
        size_resource    = lookup(topology.value, "size_resource", null)
        zone_count       = lookup(topology.value, "zone_count", null)
        node_type_data   = lookup(topology.value, "node_type_data", null)
        node_type_master = lookup(topology.value, "node_type_master", null)
        node_type_ingest = lookup(topology.value, "node_type_ingest", null)
        node_type_ml     = lookup(topology.value, "node_type_ml", null)
        autoscaling {
          min_size          = lookup(lookup(topology.value, "autoscaling", {}), "min_size", null)
          max_size          = lookup(lookup(topology.value, "autoscaling", {}), "max_size", null)
          min_size_resource = lookup(lookup(topology.value, "autoscaling", {}), "min_size_resource", null)
          max_size_resource = lookup(lookup(topology.value, "autoscaling", {}), "max_size_resource", null)
        }
      }
    }

    config {
      plugins                     = var.plugins
      user_settings_json          = var.elasticsearch_user_settings_json
      user_settings_override_json = var.elasticsearch_user_settings_override_json
    }
  }

  dynamic kibana {
    for_each = var.enable_kibana ? [0] : []
    content {
      topology {
        size                      = var.kibana_size
        zone_count                = var.kibana_zone_count
      }

      dynamic config {
        for_each = (var.kibana_user_settings_json != "") || (var.kibana_user_settings_override_json != "") ? [0] : []
        content {
          user_settings_json          = var.kibana_user_settings_json
          user_settings_override_json = var.kibana_user_settings_override_json
        }
      }
    }
  }

  dynamic apm {
    for_each = var.enable_apm ? [0] : []
    content {
      topology {
        size        = var.apm_size
        zone_count  = var.apm_zone_count
      }

      dynamic config {
        for_each = (var.apm_debug) || (var.apm_user_settings_json != "") || (var.apm_user_settings_override_json != "") ? [0] : []
        content {
          debug_enabled               = var.apm_debug
          user_settings_json          = var.apm_user_settings_json
          user_settings_override_json = var.apm_user_settings_override_json
        }
      }



    }
  }
}

locals {
  gcp_elastic_secrets = {
    elasticsearch_username       = ec_deployment.deployment.elasticsearch_username
    elasticsearch_https_endpoint = ec_deployment.deployment.elasticsearch[0].https_endpoint
    elasticsearch_password       = ec_deployment.deployment.elasticsearch_password
    kibana_https_endpoint        = var.enable_kibana ? ec_deployment.deployment.kibana[0].https_endpoint : ""

    elastic_server_connection_string = replace(
      ec_deployment.deployment.elasticsearch[0].https_endpoint,
      "https://",
      "https://${ec_deployment.deployment.elasticsearch_username}:${ec_deployment.deployment.elasticsearch_password}@"
    )
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
