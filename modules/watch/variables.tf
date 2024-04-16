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

variable "trigger" {
  description = "The trigger that defines when the watch should run"
  type        = string
  default     = null
}

variable "watch_id" {
  description = "Identifier for the watch"
  type        = string
  default     = null
}



variable "actions" {
  description = "The list of actions that will be run if the condition matches"
  type        = string
  default     = null
}

variable "active" {
  description = "Defines whether the watch is active or inactive by default"
  type        = bool
  default     = true
}

variable "condition" {
  description = "The condition that defines if the actions should be run"
  type        = string
  default     = null
}

variable "input" {
  description = "The input that defines the input that loads the data for the watch"
  type        = string
  default     = null
}

variable "metadata" {
  description = "Metadata json that will be copied into the history entries."
  type        = string
  default     = null
}

variable "throttle_period_in_millis" {
  description = "Minimum time in milliseconds between actions being run"
  type        = number
  default     = 5000
}

variable "transform" {
  description = "Processes the watch payload to prepare it for the watch actions"
  type        = string
  default     = null
}
