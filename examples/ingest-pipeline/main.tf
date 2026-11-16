module "ingest_pipeline" {
  source = "../../modules/ingest-pipeline"

  pipeline_name   = "add-write-time-pipeline"
  description     = "Adds the server-side ingest timestamp as writeTime"
  elastic_secrets = ["elastic", "password", "http://localhost:9200"]
  processors = [
    jsonencode({
      set = {
        field = "writeTime"
        value = "{{{_ingest.timestamp}}}"
      }
    })
  ]
}
