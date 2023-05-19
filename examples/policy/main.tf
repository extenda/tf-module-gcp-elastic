module "policy" {
  source = "../../modules/policy"

  create_policy   = true
  elastic_secrets = ["elastic", "password", "http://localhost:9200"]
  policies = [
    {
      name = "test-module-policy-1"
      hot = {
        min_age = "100s"
        readonly = {
          enabled = true
        }
        rollover = {
          max_age = "10s"
        }
        set_priority = {
          priority = "10"
        }
      }
    }
  ]
}
