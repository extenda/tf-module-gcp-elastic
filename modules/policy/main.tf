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
  metadata = lookup(each.value, "metadata", null)

  dynamic "hot" {
    for_each = each.value.hot != null ? [each.value.hot] : []
    content {
      min_age = lookup(hot.value, "min_age", null)

      dynamic "readonly" {
        for_each = lookup(hot.value, "read_only", null) != null ? [hot.value.read_only] : []
        content {
          enabled = lookup(hot.value, "read_only", null)
        }
      }

      dynamic "set_priority" {
        for_each = lookup(hot.value, "priority", null) != null ? [hot.value.priority] : []
        content {
          priority = lookup(hot.value, "priority", null)
        }
      }

      dynamic "forcemerge" {
        for_each = lookup(hot.value, "forcemerge_max_num_segments", null) != null ? [hot.value.forcemerge_max_num_segments] : []
        content {
          max_num_segments = lookup(hot.value, "forcemerge_max_num_segments", null)
          index_codec      = lookup(hot.value, "forcemerge_index_codec", null)
        }
      }

      dynamic "rollover" {
        for_each = lookup(hot.value, "rollover_max_age", null) != null ? [hot.value.rollover_max_age] : []
        content {
          max_age                = lookup(hot.value, "rollover_max_age", null)
          max_docs               = lookup(hot.value, "rollover_max_docs", null)
          max_primary_shard_size = lookup(hot.value, "rollover_max_primary_shard_size", null)
          max_size               = lookup(hot.value, "rollover_max_primary_shard_size", null)
        }
      }

      dynamic "unfollow" {
        for_each = lookup(hot.value, "unfollow", null) != null ? [hot.value.unfollow] : []
        content {
          enabled = lookup(hot.value, "unfollow", null)
        }
      }

      dynamic "shrink" {
        for_each = lookup(hot.value, "shrink_max_primary_shard_size", null) != null ? [hot.value.shrink_max_primary_shard_size] : []
        content {
          max_primary_shard_size = lookup(hot.value, "shrink_max_primary_shard_size", null)
          number_of_shards       = lookup(hot.value, "shrink_number_of_shards", null)
        }
      }

      dynamic "searchable_snapshot" {
        for_each = lookup(hot.value, "snapshot_repository", null) != null ? [hot.value.snapshot_repository] : []
        content {
          snapshot_repository = lookup(hot.value, "snapshot_repository", null)
          force_merge_index   = lookup(hot.value, "snapshot_force_merge_index", null)
        }
      }
    }
  }

  dynamic "warm" {
    for_each = each.value.warm != null ? [each.value.warm] : []
    content {
      min_age = lookup(warm.value, "min_age", null)

      dynamic "allocate" {
        for_each = lookup(warm.value, "exclude", null) != null ? [warm.value.exclude] : []
        content {
          exclude               = lookup(warm.value, "exclude", null)
          include               = lookup(warm.value, "include", null)
          number_of_replicas    = lookup(warm.value, "number_of_replicas", null)
          require               = lookup(warm.value, "require", null)
          total_shards_per_node = lookup(warm.value, "total_shards_per_node", null)
        }
      }

      dynamic "migrate" {
        for_each = lookup(warm.value, "migrate", null) != null ? [warm.value.migrate] : []
        content {
          enabled = lookup(warm.value, "migrate", null)
        }
      }

      dynamic "readonly" {
        for_each = lookup(warm.value, "read_only", null) != null ? [warm.value.read_only] : []
        content {
          enabled = lookup(warm.value, "read_only", null)
        }
      }

      dynamic "set_priority" {
        for_each = lookup(warm.value, "priority", null) != null ? [warm.value.priority] : []
        content {
          priority = lookup(warm.value, "priority", null)
        }
      }

      dynamic "forcemerge" {
        for_each = lookup(warm.value, "forcemerge_max_num_segments", null) != null ? [warm.value.forcemerge_max_num_segments] : []
        content {
          max_num_segments = lookup(warm.value, "forcemerge_max_num_segments", null)
          index_codec      = lookup(warm.value, "forcemerge_index_codec", null)
        }
      }

      dynamic "unfollow" {
        for_each = lookup(warm.value, "unfollow", null) != null ? [warm.value.unfollow] : []
        content {
          enabled = lookup(warm.value, "unfollow", null)
        }
      }

      dynamic "shrink" {
        for_each = lookup(warm.value, "shrink_max_primary_shard_size", null) != null ? [warm.value.shrink_max_primary_shard_size] : []
        content {
          max_primary_shard_size = lookup(warm.value, "shrink_max_primary_shard_size", null)
          number_of_shards       = lookup(warm.value, "shrink_number_of_shards", null)
        }
      }
    }
  }

  dynamic "cold" {
    for_each = each.value.cold != null ? [each.value.cold] : []
    content {
      min_age = lookup(cold.value, "min_age", null)

      dynamic "allocate" {
        for_each = lookup(cold.value, "exclude", null) != null ? [cold.value.exclude] : []
        content {
          exclude               = lookup(cold.value, "exclude", null)
          include               = lookup(cold.value, "include", null)
          number_of_replicas    = lookup(cold.value, "number_of_replicas", null)
          require               = lookup(cold.value, "require", null)
          total_shards_per_node = lookup(cold.value, "total_shards_per_node", null)
        }
      }

      dynamic "readonly" {
        for_each = lookup(cold.value, "read_only", null) != null ? [cold.value.read_only] : []
        content {
          enabled = lookup(cold.value, "read_only", null)
        }
      }

      dynamic "migrate" {
        for_each = lookup(cold.value, "migrate", null) != null ? [cold.value.migrate] : []
        content {
          enabled = lookup(cold.value, "migrate", null)
        }
      }

      dynamic "freeze" {
        for_each = lookup(cold.value, "freeze", null) != null ? [cold.value.freeze] : []
        content {
          enabled = lookup(cold.value, "freeze", null)
        }
      }

      dynamic "set_priority" {
        for_each = lookup(cold.value, "priority", null) != null ? [cold.value.priority] : []
        content {
          priority = lookup(cold.value, "priority", null)
        }
      }

      dynamic "unfollow" {
        for_each = lookup(cold.value, "unfollow", null) != null ? [cold.value.unfollow] : []
        content {
          enabled = lookup(cold.value, "unfollow", null)
        }
      }

      dynamic "searchable_snapshot" {
        for_each = lookup(cold.value, "snapshot_repository", null) != null ? [cold.value.snapshot_repository] : []
        content {
          snapshot_repository = lookup(cold.value, "snapshot_repository", null)
          force_merge_index   = lookup(cold.value, "snapshot_force_merge_index", null)
        }
      }
    }
  }

  dynamic "delete" {
    for_each = each.value.delete != null ? [each.value.delete] : []
    content {
      min_age = lookup(delete.value, "min_age", null)

      dynamic "delete" {
        for_each = lookup(delete.value, "delete", null) != null ? [delete.value.delete] : []
        content {
          delete_searchable_snapshot = lookup(delete.value, "delete_searchable_snapshot ", null)
        }
      }

      dynamic "wait_for_snapshot" {
        for_each = lookup(delete.value, "policy", null) != null ? [delete.value.policy] : []
        content {
          policy = lookup(cold.value, "policy", null)
        }
      }
    }
  }

  dynamic "frozen" {
    for_each = each.value.frozen != null ? [each.value.frozen] : []
    content {
      min_age = lookup(frozen.value, "min_age", null)

      dynamic "searchable_snapshot" {
        for_each = lookup(frozen.value, "snapshot_repository", null) != null ? [frozen.value.snapshot_repository] : []
        content {
          snapshot_repository = lookup(frozen.value, "snapshot_repository ", null)
          force_merge_index   = lookup(frozen.value, "force_merge_index ", null)
        }
      }
    }
  }
}