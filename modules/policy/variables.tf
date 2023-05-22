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
  type = list(object(
    {
      name     = string
      metadata = optional(string)

      hot = optional(object({
        min_age = optional(string)

        rollover = optional(object({
          max_age                = optional(string)
          max_docs               = optional(number)
          max_primary_shard_size = optional(string)
          max_size               = optional(string)
        }))

        readonly = optional(object({
          enabled = optional(bool)
        }))

        forcemerge = optional(object({
          max_num_segments = optional(number)
          index_codec      = optional(string)
        }))

        searchable_snapshot = optional(object({
          snapshot_repository = optional(string)
          force_merge_index   = optional(bool)
        }))

        set_priority = optional(object({
          priority = optional(number)
        }))

        shrink = optional(object({
          max_primary_shard_size = optional(string)
          number_of_shards       = optional(number)
        }))

        unfollow = optional(object({
          enabled = optional(bool)
        }))
      }))

      cold = optional(object({
        min_age = optional(string)

        allocate = optional(object({
          exclude               = optional(string)
          include               = optional(string)
          number_of_replica     = optional(number)
          require               = optional(string)
          total_shards_per_node = optional(number)
        }))

        freeze = optional(object({
          enabled = optional(bool)
        }))

        migrate = optional(object({
          enabled = optional(bool)
        }))

        readonly = optional(object({
          enabled = optional(bool)
        }))

        searchable_snapshot = optional(object({
          snapshot_repository = optional(string)
          force_merge_index   = optional(bool)
        }))

        set_priority = optional(object({
          priority = optional(number)
        }))

        unfollow = optional(object({
          enabled = optional(bool)
        }))
      }))

      warm = optional(object({
        min_age = optional(string)

        allocate = optional(object({
          exclude               = optional(string)
          include               = optional(string)
          number_of_replica     = optional(number)
          require               = optional(string)
          total_shards_per_node = optional(number)
        }))

        forcemerge = optional(object({
          max_num_segments = optional(number)
          index_codec      = optional(string)
        }))

        migrate = optional(object({
          enabled = optional(bool)
        }))

        readonly = optional(object({
          enabled = optional(bool)
        }))

        unfollow = optional(object({
          enabled = optional(bool)
        }))

        set_priority = optional(object({
          priority = optional(number)
        }))

        shrink = optional(object({
          max_primary_shard_size = optional(string)
          number_of_shards       = optional(number)
        }))
      }))

      delete = optional(object({
        min_age = optional(string)

        delete = optional(object({
          delete_searchable_snapshot = optional(bool)
        }))

        wait_for_snapshot = optional(object({
          policy = optional(string)
        }))
      }))

      frozen = optional(object({
        min_age = optional(string)

        searchable_snapshot = optional(object({
          snapshot_repository = optional(string)
          force_merge_index   = optional(bool)
        }))
      }))
    }
  ))
  default = []
}
