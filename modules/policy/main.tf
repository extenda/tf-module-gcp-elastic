data "google_secret_manager_secret_version" "elastic_secrets" {
  for_each = (var.project_id != "") ? toset(var.elastic_secrets) : []
  project  = var.project_id
  secret   = each.key
}

provider "elasticstack" {
  elasticsearch {
    username  = (var.project_id != "") ? data.google_secret_manager_secret_version.elastic_secrets["elasticsearch_username"].secret_data : var.elastic_secrets[0]
    password  = (var.project_id != "") ? data.google_secret_manager_secret_version.elastic_secrets["elasticsearch_password"].secret_data : var.elastic_secrets[1]
    endpoints = (var.project_id != "") ? ["${data.google_secret_manager_secret_version.elastic_secrets["elasticsearch_https_endpoint"].secret_data}"] : [var.elastic_secrets[2]]
  }
}

resource "elasticstack_elasticsearch_index_lifecycle" "index_policy" {
  for_each = var.create_policy ? { for i in var.policies : i.name => i } : {}

  name     = each.value.name
  metadata = try(each.value.metadata, null)

  dynamic "hot" {
    for_each = try([each.value.hot], [])
    content {
      min_age = try(hot.value.min_age, null)

      dynamic "readonly" {
        for_each = try([hot.value.read_only], [])
        content {
          enabled = try(hot.value.read_only, null)
        }
      }

      dynamic "set_priority" {
        for_each = try([hot.value.priority], [])
        content {
          priority = try(hot.value.priority, null)
        }
      }

      dynamic "forcemerge" {
        for_each = try([hot.value.forcemerge_max_num_segments], [])
        content {
          max_num_segments = try(hot.value.forcemerge_max_num_segments, null)
          index_codec      = try(hot.value.forcemerge_index_codec, null)
        }
      }

      dynamic "rollover" {
        for_each = try([hot.value.rollover_max_age], [])
        content {
          max_age                = try(hot.value.rollover_max_age, null)
          max_docs               = try(hot.value.rollover_max_docs, null)
          max_primary_shard_size = try(hot.value.rollover_max_primary_shard_size, null)
          max_size               = try(hot.value.rollover_max_primary_shard_size, null)
        }
      }

      dynamic "unfollow" {
        for_each = try([hot.value.unfollow], [])
        content {
          enabled = try(hot.value.unfollow, null)
        }
      }

      dynamic "shrink" {
        for_each = try([hot.value.shrink_max_primary_shard_size], [])
        content {
          max_primary_shard_size = try(hot.value.shrink_max_primary_shard_size, null)
          number_of_shards       = try(hot.value.shrink_number_of_shards, null)
        }
      }

      dynamic "searchable_snapshot" {
        for_each = try([hot.value.snapshot_repository], [])
        content {
          snapshot_repository = try(hot.value.snapshot_repository, null)
          force_merge_index   = try(hot.value.snapshot_force_merge_index, null)
        }
      }
    }
  }

  dynamic "warm" {
    for_each = try([each.value.warm], [])
    content {
      min_age = try(warm.value.min_age, null)

      dynamic "allocate" {
        for_each = try([warm.value.exclude], [])
        content {
          exclude               = try(warm.value.exclude, null)
          include               = try(warm.value.include, null)
          number_of_replicas    = try(warm.value.number_of_replicas, null)
          require               = try(warm.value.require, null)
          total_shards_per_node = try(warm.value.total_shards_per_node, null)
        }
      }

      dynamic "migrate" {
        for_each = try([warm.value.migrate], [])
        content {
          enabled = try(warm.value.migrate, null)
        }
      }

      dynamic "readonly" {
        for_each = try([warm.value.read_only], [])
        content {
          enabled = try(warm.value.read_only, null)
        }
      }

      dynamic "set_priority" {
        for_each = try([warm.value.priority], [])
        content {
          priority = try(warm.value.priority, null)
        }
      }

      dynamic "forcemerge" {
        for_each = try([warm.value.forcemerge_max_num_segments], [])
        content {
          max_num_segments = try(warm.value.forcemerge_max_num_segments, null)
          index_codec      = try(warm.value.forcemerge_index_codec, null)
        }
      }

      dynamic "unfollow" {
        for_each = try([warm.value.unfollow], [])
        content {
          enabled = try(warm.value.unfollow, null)
        }
      }

      dynamic "shrink" {
        for_each = try([warm.value.shrink_max_primary_shard_size], [])
        content {
          max_primary_shard_size = try(warm.value.shrink_max_primary_shard_size, null)
          number_of_shards       = try(warm.value.shrink_number_of_shards, null)
        }
      }
    }
  }

  dynamic "cold" {
    for_each = try([each.value.cold], [])
    content {
      min_age = try(cold.value.min_age, null)

      dynamic "readonly" {
        for_each = try([cold.value.read_only], [])
        content {
          enabled = try(cold.value.read_only, null)
        }
      }
      dynamic "allocate" {
        for_each = try([cold.value.exclude], [])
        content {
          exclude               = try(cold.value.exclude, null)
          include               = try(cold.value.include, null)
          number_of_replicas    = try(cold.value.number_of_replicas, null)
          require               = try(cold.value.require, null)
          total_shards_per_node = try(cold.value.total_shards_per_node, null)
        }
      }

      dynamic "migrate" {
        for_each = try([cold.value.migrate], [])
        content {
          enabled = try(cold.value.migrate, null)
        }
      }

      dynamic "freeze" {
        for_each = try([cold.value.freeze], [])
        content {
          enabled = try(cold.value.freeze, null)
        }
      }

      dynamic "set_priority" {
        for_each = try([cold.value.priority], [])
        content {
          priority = try(cold.value.priority, null)
        }
      }

      dynamic "unfollow" {
        for_each = try([cold.value.unfollow], [])
        content {
          enabled = try(cold.value.unfollow, null)
        }
      }

      dynamic "searchable_snapshot" {
        for_each = try([cold.value.snapshot_repository], [])
        content {
          snapshot_repository = try(cold.value.snapshot_repository, null)
          force_merge_index   = try(cold.value.snapshot_force_merge_index, null)
        }
      }
    }
  }

  dynamic "delete" {
    for_each = try([each.value.delete], [])
    content {
      min_age = try(delete.value.min_age, null)

      dynamic "delete" {
        for_each = try([delete.value.delete], [])
        content {
          delete_searchable_snapshot = try(delete.value.delete_searchable_snapshot, null)
        }
      }

      dynamic "wait_for_snapshot" {
        for_each = try([delete.value.policy], [])
        content {
          policy = try(cold.value.policy, null)
        }
      }
    }
  }

  dynamic "frozen" {
    for_each = try([each.value.frozen], [])
    content {
      min_age = try(frozen.value.min_age, null)

      dynamic "searchable_snapshot" {
        for_each = try([frozen.value.snapshot_repository], [])
        content {
          snapshot_repository = try(frozen.value.snapshot_repository, null)
          force_merge_index   = try(frozen.value.force_merge_index, null)
        }
      }
    }
  }
}