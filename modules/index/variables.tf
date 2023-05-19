variable "mappings" {
  description = "Mapping for fields in the index. If specified, this mapping can include: field names, field data types, mapping parameters"
  type        = string
}

variable "index_name" {
  description = "Name of the index to be created"
  type        = string
}

variable "number_of_shards" {
  description = "Number of shards for the index"
  type        = number
}

variable "number_of_replicas" {
  description = "Number of shard replicas"
  type        = number
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

variable "alias" {
  description = "Aliases for the index"
  type        = list(map(string))
  default     = null
}

variable "number_of_routing_shards" {
  description = "Value used with number_of_shards to route documents to a primary shard"
  type        = number
  default     = 1
}

variable "routing_partition_size" {
  description = "The number of shards a custom routing value can go to"
  type        = number
  default     = 1
}

variable "refresh_interval" {
  description = "How often to perform a refresh operation, which makes recent changes to the index visible to search. Can be set to -1 to disable refresh"
  type        = string
  default     = "1s"
}

variable "search_idle_after" {
  description = "How long a shard can not receive a search or get request until it’s considered search idle"
  type        = string
  default     = "30s"
}

variable "lifecycle_policy" {
  description = "Name of the lifecycle policy to attach to the index"
  type        = string
  default     = null
}
