## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.4.6 |
| elasticstack | 0.5.0 |
| google | ~> 4.62.0 |

## Providers

| Name | Version |
|------|---------|
| elasticstack | 0.5.0 |
| google | ~> 4.62.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_policy | Wether or not to create lifecycle policy | `bool` | `false` | no |
| elastic\_secrets | List of secrets to extract from Secret Manager for Auth | `list(string)` | <pre>[<br>  "elasticsearch_username",<br>  "elasticsearch_password",<br>  "elasticsearch_https_endpoint"<br>]</pre> | no |
| policies | Configuration for lifecycle policy | <pre>list(object(<br>    {<br>      name     = string<br>      metadata = optional(string)<br><br>      hot = optional(object({<br>        min_age = optional(string)<br><br>        rollover = optional(object({<br>          max_age                = optional(string)<br>          max_docs               = optional(number)<br>          max_primary_shard_size = optional(string)<br>          max_size               = optional(string)<br>        }))<br><br>        readonly = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        forcemerge = optional(object({<br>          max_num_segments = optional(number)<br>          index_codec      = optional(string)<br>        }))<br><br>        searchable_snapshot = optional(object({<br>          snapshot_repository = optional(string)<br>          force_merge_index   = optional(bool)<br>        }))<br><br>        set_priority = optional(object({<br>          priority = optional(number)<br>        }))<br><br>        shrink = optional(object({<br>          max_primary_shard_size = optional(string)<br>          number_of_shards       = optional(number)<br>        }))<br><br>        unfollow = optional(object({<br>          enabled = optional(bool)<br>        }))<br>      }))<br><br>      cold = optional(object({<br>        min_age = optional(string)<br><br>        allocate = optional(object({<br>          exclude               = optional(string)<br>          include               = optional(string)<br>          number_of_replica     = optional(number)<br>          require               = optional(string)<br>          total_shards_per_node = optional(number)<br>        }))<br><br>        freeze = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        migrate = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        readonly = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        searchable_snapshot = optional(object({<br>          snapshot_repository = optional(string)<br>          force_merge_index   = optional(bool)<br>        }))<br><br>        set_priority = optional(object({<br>          priority = optional(number)<br>        }))<br><br>        unfollow = optional(object({<br>          enabled = optional(bool)<br>        }))<br>      }))<br><br>      warm = optional(object({<br>        min_age = optional(string)<br><br>        allocate = optional(object({<br>          exclude               = optional(string)<br>          include               = optional(string)<br>          number_of_replica     = optional(number)<br>          require               = optional(string)<br>          total_shards_per_node = optional(number)<br>        }))<br><br>        forcemerge = optional(object({<br>          max_num_segments = optional(number)<br>          index_codec      = optional(string)<br>        }))<br><br>        migrate = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        readonly = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        unfollow = optional(object({<br>          enabled = optional(bool)<br>        }))<br><br>        set_priority = optional(object({<br>          priority = optional(number)<br>        }))<br><br>        shrink = optional(object({<br>          max_primary_shard_size = optional(string)<br>          number_of_shards       = optional(number)<br>        }))<br>      }))<br><br>      delete = optional(object({<br>        min_age = optional(string)<br><br>        delete = optional(object({<br>          delete_searchable_snapshot = optional(bool)<br>        }))<br><br>        wait_for_snapshot = optional(object({<br>          policy = optional(string)<br>        }))<br>      }))<br><br>      frozen = optional(object({<br>        min_age = optional(string)<br><br>        searchable_snapshot = optional(object({<br>          snapshot_repository = optional(string)<br>          force_merge_index = optional(bool)<br>        }))<br>      }))<br>    }<br>  ))</pre> | `[]` | no |
| project\_id | Project ID where Elastic secrets are stored | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Internal identifier of the resource |
