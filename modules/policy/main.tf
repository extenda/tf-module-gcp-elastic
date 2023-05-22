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
    for_each = lookup(each.value, "hot", null) != null ? [each.value.hot] : []
    content {
      min_age = lookup(hot.value, "min_age", null)

      dynamic "readonly" {
        for_each = lookup(hot.value, "readonly", null) != null ? [hot.value.readonly] : []
        content {
          enabled = try(readonly.value.enabled, null)
        }
      }

      dynamic "set_priority" {
        for_each = lookup(hot.value, "set_priority", null) != null ? [hot.value.set_priority] : []
        content {
          priority = try(set_priority.value.priority, null)
        }
      }

      dynamic "forcemerge" {
        for_each = lookup(hot.value, "forcemerge", null) != null ? [hot.value.forcemerge] : []
        content {
          max_num_segments = try(forcemerge.value.max_num_segments, null)
          index_codec      = try(forcemerge.value.index_codec, null)
        }
      }

      dynamic "rollover" {
        for_each = lookup(hot.value, "rollover", null) != null ? [hot.value.rollover] : []
        content {
          max_age                = try(rollover.value.max_age, null)
          max_docs               = try(rollover.value.max_docs, null)
          max_primary_shard_size = try(rollover.value.max_primary_shard_size, null)
          max_size               = try(rollover.value.max_primary_shard_size, null)
        }
      }

      dynamic "unfollow" {
        for_each = lookup(hot.value, "unfollow", null) != null ? [hot.value.unfollow] : []
        content {
          enabled = try(unfollow.value.enabled, null)
        }
      }

      dynamic "shrink" {
        for_each = lookup(hot.value, "shrink", null) != null ? [hot.value.shrink] : []
        content {
          max_primary_shard_size = try(shrink.max_primary_shard_size, null)
          number_of_shards       = try(shrink.number_of_shards, null)
        }
      }

      dynamic "searchable_snapshot" {
        for_each = lookup(hot.value, "searchable_snapshot", null) != null ? [hot.value.searchable_snapshot] : []
        content {
          snapshot_repository = try(searchable_snapshot.value.snapshot_repository, null)
          force_merge_index   = try(searchable_snapshot.value.force_merge_index, null)
        }
      }
    }
  }

  dynamic "warm" {
    for_each = lookup(each.value, "warm", null) != null ? [each.value.warm] : []
    content {
      min_age = lookup(warm.value, "min_age", null)

      dynamic "allocate" {
        for_each = lookup(warm.value, "allocate", null) != null ? [warm.value.allocate] : []
        content {
          exclude               = try(allocate.value.exclude, null)
          include               = try(allocate.value.include, null)
          number_of_replicas    = try(allocate.value.number_of_replicas, null)
          require               = try(allocate.value.require, null)
          total_shards_per_node = try(allocate.value.total_shards_per_node, null)
        }
      }

      dynamic "migrate" {
        for_each = lookup(warm.value, "migrate", null) != null ? [warm.value.migrate] : []
        content {
          enabled = try(migrate.value.enabled, null)
        }
      }

      dynamic "readonly" {
        for_each = lookup(warm.value, "readonly", null) != null ? [warm.value.readonly] : []
        content {
          enabled = try(readonly.value.enabled, null)
        }
      }

      dynamic "set_priority" {
        for_each = lookup(warm.value, "set_priority", null) != null ? [warm.value.set_priority] : []
        content {
          priority = try(set_priority.value.enabled, null)
        }
      }

      dynamic "forcemerge" {
        for_each = lookup(warm.value, "forcemerge", null) != null ? [warm.value.forcemerge] : []
        content {
          max_num_segments = try(forcemerge.value.max_num_segments, null)
          index_codec      = try(forcemerge.value.index_codec, null)
        }
      }

      dynamic "unfollow" {
        for_each = lookup(warm.value, "unfollow", null) != null ? [warm.value.unfollow] : []
        content {
          enabled = try(unfollow.value.enabled, null)
        }
      }

      dynamic "shrink" {
        for_each = lookup(warm.value, "shrink", null) != null ? [warm.value.shrink] : []
        content {
          max_primary_shard_size = try(shrink.value.max_primary_shard_size, null)
          number_of_shards       = try(shrink.value.number_of_shards, null)
        }
      }
    }
  }

  dynamic "cold" {
    for_each = lookup(each.value, "cold", null) != null ? [each.value.cold] : []
    content {
      min_age = lookup(cold.value, "min_age", null)

      dynamic "readonly" {
        for_each = lookup(cold.value, "readonly", null) != null ? [cold.value.readonly] : []
        content {
          enabled = try(readonly.value.enabled, null)
        }
      }
      dynamic "allocate" {
        for_each = lookup(cold.value, "allocate", null) != null ? [cold.value.allocate] : []
        content {
          exclude               = try(allocate.value.exclude, null)
          include               = try(allocate.value.include, null)
          number_of_replicas    = try(allocate.value.number_of_replicas, null)
          require               = try(allocate.value.require, null)
          total_shards_per_node = try(allocate.value.total_shards_per_node, null)
        }
      }

      dynamic "migrate" {
        for_each = lookup(cold.value, "migrate", null) != null ? [cold.value.migrate] : []
        content {
          enabled = try(migrate.value.enabled, null)
        }
      }

      dynamic "freeze" {
        for_each = lookup(cold.value, "freeze", null) != null ? [cold.value.freeze] : []
        content {
          enabled = try(freeze.value.enabled, null)
        }
      }

      dynamic "set_priority" {
        for_each = lookup(cold.value, "set_priority", null) != null ? [cold.value.set_priority] : []
        content {
          priority = try(set_priority.value.priority, null)
        }
      }

      dynamic "unfollow" {
        for_each = lookup(cold.value, "unfollow", null) != null ? [cold.value.unfollow] : []
        content {
          enabled = try(unfollow.value.enabled, null)
        }
      }

      dynamic "searchable_snapshot" {
        for_each = lookup(cold.value, "searchable_snapshot", null) != null ? [cold.value.searchable_snapshot] : []
        content {
          snapshot_repository = try(searchable_snapshot.value.snapshot_repository, null)
          force_merge_index   = try(searchable_snapshot.value.force_merge_index, null)
        }
      }
    }
  }

  dynamic "delete" {
    for_each = lookup(each.value, "delete", null) != null ? [each.value.delete] : []
    content {
      min_age = lookup(delete.value, "min_age", null)

      dynamic "delete" {
        for_each = lookup(delete.value, "delete", null) != null ? [delete.value.delete] : []
        content {
          delete_searchable_snapshot = try(delete.value.delete_searchable_snapshot, null)
        }
      }

      dynamic "wait_for_snapshot" {
        for_each = lookup(delete.value, "wait_for_snapshot", null) != null ? [delete.value.wait_for_snapshot] : []
        content {
          policy = try(wait_for_snapshot.value.policy, null)
        }
      }
    }
  }

  dynamic "frozen" {
    for_each = lookup(each.value, "frozen", null) != null ? [each.value.frozen] : []
    content {
      min_age = lookup(frozen.value, "min_age", null)

      dynamic "searchable_snapshot" {
        for_each = lookup(frozen.value, "searchable_snapshot", null) != null ? [frozen.value.searchable_snapshot] : []
        content {
          snapshot_repository = try(searchable_snapshot.value.snapshot_repository, null)
          force_merge_index   = try(searchable_snapshot.value.force_merge_index, null)
        }
      }
    }
  }
}
