variable "pipeline_name" {
  description = "Name of the ingest pipeline"
  type        = string
}

variable "description" {
  description = "Description of the ingest pipeline"
  type        = string
  default     = null
}

variable "processors" {
  description = "List of processors, each one a JSON-encoded string. Build them with jsonencode(), e.g. jsonencode({ set = { field = \"writeTime\", value = \"{{{_ingest.timestamp}}}\" } })"
  type        = list(string)
}

variable "on_failure" {
  description = "Optional list of processors, each one a JSON-encoded string, to run when a processor in the pipeline fails"
  type        = list(string)
  default     = null
}

variable "metadata" {
  description = "Optional JSON-encoded string with metadata about the pipeline, such as a version number or the owner"
  type        = string
  default     = null
}

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
