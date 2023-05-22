module "index" {
  source = "../../modules/index"

  index_name         = "test-index"
  elastic_secrets    = ["elastic", "password", "http://localhost:9200"]
  number_of_shards   = 1
  number_of_replicas = 1
  mappings           = file("mappings.json")
  alias = [
    {
      name           = "test-module-index-alias"
      is_write_index = true
    }
  ]
}
