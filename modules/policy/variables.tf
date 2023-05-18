variable "elastic_secrets" {
  description = "List of secrets to extract from Secret Manager for Auth"
  type        = list(string)
  default     = ["elasticsearch_username", "elasticsearch_password", "elasticsearch_https_endpoint"]
}

variable "project_id" {
  description = "Project ID where Elastic secrets are stored"
  type        = string
  default     = ""
}

variable "create_policy" {
  description = "Wether or not to create lifecycle policy"
  type        = bool
  default     = false
}

variable "policies" {
  description = "Configuration for lifecycle policy"
  type        = list(any)
  default     = []
}
