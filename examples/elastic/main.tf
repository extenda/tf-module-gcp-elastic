module "elastic" {
  source = "../../"

  project_id             = "project-id"
  deployment_template_id = "gcp-cpu-optimized-v3"
  elastic_version        = "7.17.4"
  name                   = "test-elastic"

  topology = [
    {
      id         = "hot_content"
      size       = "8g"
      zone_count = 2
      autoscaling = {
        max_size = "128g"
      }
    },
    {
      id         = "warm"
      size       = "4g"
      zone_count = 2
      autoscaling = {
        min_size = "4g"
        max_size = "128g"
      }
    }
  ]

  observability_enable_logs    = false
  observability_enable_metrics = false
}
