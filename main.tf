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

data "google_secret_manager_secret_version" "elastic_secret" {
  project = var.elastic_project_gcp_secret
  secret  = var.elastic_api_key
}

provider "ec" {
  apikey = (var.elastic_project_gcp_secret != "") ? data.google_secret_manager_secret_version.elastic_secret.secret_data : var.elastic_api_key
}

resource "ec_deployment" "deployment" {
  name  = var.name
  alias = var.alias
  tags  = var.tags

  region                 = var.region
  version                = var.elastic_version
  deployment_template_id = var.deployment_template_id


  elasticsearch {
    autoscale = var.autoscale

    dynamic "topology" {
      for_each = var.topology
      content {
        id               = topology.value.id
        size             = lookup(topology.value, "size", null)
        size_resource    = lookup(topology.value, "size_resource", "memory")
        zone_count       = lookup(topology.value, "zone_count", null)
        node_type_data   = lookup(topology.value, "node_type_data", "")
        node_type_master = lookup(topology.value, "node_type_master", "")
        node_type_ingest = lookup(topology.value, "node_type_ingest", "")
        node_type_ml     = lookup(topology.value, "node_type_ml", "")

        dynamic "autoscaling" {
          for_each = lookup(topology.value, "autoscaling", null) != null ? [topology.value.autoscaling] : []
          content {
            min_size          = lookup(autoscaling.value, "min_size", "")
            max_size          = lookup(autoscaling.value, "max_size", "")
            min_size_resource = lookup(autoscaling.value, "min_size_resource", "")
            max_size_resource = lookup(autoscaling.value, "max_size_resource", "")
          }
        }
      }
    }

    dynamic "config" {
      for_each = (var.plugins != []) || (var.elasticsearch_user_settings_json != "") || (var.elasticsearch_user_settings_override_json != "") ? [0] : []
      content {
        plugins                     = var.plugins
        user_settings_json          = var.elasticsearch_user_settings_json
        user_settings_override_json = var.elasticsearch_user_settings_override_json
      }
    }
  }

  dynamic "kibana" {
    for_each = var.enable_kibana ? [0] : []
    content {
      topology {
        size       = var.kibana_size
        zone_count = var.kibana_zone_count
      }

      dynamic "config" {
        for_each = (var.kibana_user_settings_json != "") || (var.kibana_user_settings_override_json != "") ? [0] : []
        content {
          user_settings_json          = var.kibana_user_settings_json
          user_settings_override_json = var.kibana_user_settings_override_json
        }
      }
    }
  }

  dynamic "apm" {
    for_each = var.enable_apm ? [0] : []
    content {
      topology {
        size       = var.apm_size
        zone_count = var.apm_zone_count
      }

      dynamic "config" {
        for_each = (var.apm_debug) || (var.apm_user_settings_json != "") || (var.apm_user_settings_override_json != "") ? [0] : []
        content {
          debug_enabled               = var.apm_debug
          user_settings_json          = var.apm_user_settings_json
          user_settings_override_json = var.apm_user_settings_override_json
        }
      }
    }
  }

  dynamic "observability" {
    for_each = var.observability_deployment_id != "" ? [0] : []
    content {
      deployment_id = var.observability_deployment_id
      logs          = var.observability_enable_logs
      metrics       = var.observability_enable_metrics
    }
  }
}

resource "google_secret_manager_secret" "elastic_secret_id" {
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
  for_each = local.gcp_elastic_secrets

  secret      = google_secret_manager_secret.elastic_secret_id[each.key].id
  secret_data = each.value

  depends_on = [ec_deployment.deployment]
}
