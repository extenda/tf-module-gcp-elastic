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

variable deployment_id {
  description = "Deployment Template identifier to create the deployment from"
  type        = string
  default     = "gcp-io-optimized"
}

variable project_id {
  description = "Project ID where Elastic secrets are stored"
  type        = string
  default     = ""
}

variable elastic_insatnce_config_id {
  description = "Instance Configuration ID from the deployment template"
  type        = string
  default     = "gcp.data.highio.1"
}

variable autoscale {
  description = "Enable Elasticsearch autoscalling"
  type        = bool
  default     = false
}

variable topology {
  description = "Elasticsearch cluster topology"
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
