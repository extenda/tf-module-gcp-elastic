variable elastic_project_gcp_secret {
  description = "GCP project ID having secret for Elastic Cloud credentials"
  type        = string
  default     = "tf-admin-90301274"
}

variable elastic_apikey {
  description = "Elastic Cloud API key to extract from var.elastic_project_gcp_secret"
  type        = string
  default     = "elastic-api-key"
}

variable name {
  description = "The name for the deployment"
  type        = string
}

variable alias {
  description = "Deployment alias, affects the format of the resource URLs"
  type        = string
  default     = null
}

variable tags {
  description = "Key value map of arbitrary string tags"
  type        = map(string)
  default     = {}
}

variable region {
  description = "Region where to create the deployment"
  type        = string
  default     = "gcp-europe-west1"
}

variable elastic_version {
  description = "Elastic Stack version to use for all of the deployment resources"
  type        = string
  default     = "7.9.3"
}

variable deployment_template_id {
  description = "Deployment Template identifier to create the deployment from"
  type        = string
  default     = "gcp-io-optimized"
}

variable project_id {
  description = "Project ID where Elastic secrets are stored"
  type        = string
  default     = ""
}

variable autoscale {
  description = "Enable Elasticsearch autoscalling"
  type        = bool
  default     = false
}

variable topology {
  description = "Elasticsearch cluster topology list (see https://registry.terraform.io/providers/elastic/ec/latest/docs/resources/ec_deployment#topology)"
  type        = list
  default     = []
}



variable plugins {
  description = "List of Elasticsearch supported plugins, which vary from version to version"
  type        = list
  default     = [""]
}

variable elasticsearch_user_settings_json {
  description = "JSON-formatted user level elasticsearch.yml setting overrides"
  type        = string
  default     = ""
}

variable elasticsearch_user_settings_override_json {
  description = "JSON-formatted admin (ECE) level elasticsearch.yml setting overrides"
  type        = string
  default     = ""
}

variable observability_deployment_id {
  description = "Destination deployment ID for the shipped logs and monitoring metrics"
  type        = string
  default     = ""
}

variable observability_enable_logs {
  description = "Enables or disables shipping logs"
  type        = bool
  default     = true
}

variable observability_enable_metrics {
  description = "Enables or disables shipping metrics"
  type        = bool
  default     = true
}



# Kibana config
variable enable_kibana {
  description = "Deploy Kibana or not"
  type        = bool
  default     = false
}

variable kibana_size {
  description = "Amount of memory per node (GB)"
  type        = string
  default     = "1g"
}

variable kibana_zone_count {
  description = "Number of zones that the Kibana cluster will span. This is used to set HA"
  type        = number
  default     = 1
}

variable kibana_user_settings_json {
  description = "JSON-formatted user level kibana.yml setting overrides"
  type        = string
  default     = ""
}

variable kibana_user_settings_override_json {
  description = "JSON-formatted admin (ECE) level kibana.yml setting overrides"
  type        = string
  default     = ""
}



# APM config
variable enable_apm {
  description = "Deploy APM to the cluster or not"
  type        = bool
  default     = false
}

variable apm_size {
  description = "Amount of memory (RAM) per topology element in the XXg notation"
  type        = string
  default     = "1g"
}

variable apm_zone_count {
  description = "Number of zones that the APM deployment will span. This is used to set HA"
  type        = number
  default     = 1
}

variable apm_debug {
  description = "Enable debug mode for APM servers"
  type        = bool
  default     = false
}

variable apm_user_settings_json {
  description = "JSON-formatted user level apm.yml setting overrides"
  type        = string
  default     = ""
}

variable apm_user_settings_override_json {
  description = "JSON-formatted admin (ECE) level apm.yml setting overrides"
  type        = string
  default     = ""
}
