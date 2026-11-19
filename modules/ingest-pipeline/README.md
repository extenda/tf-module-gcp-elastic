## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.4.6 |
| elasticstack | 0.12.2 |
| google | ~> 4.62.0 |

## Providers

| Name | Version |
|------|---------|
| elasticstack | 0.12.2 |
| google | ~> 4.62.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | Description of the ingest pipeline | `string` | `null` | no |
| elastic\_secrets | Names of the three secrets to extract from Secret Manager for Auth, in this order: username, password and endpoint. When project\_id is empty, the values themselves are used as username, password and endpoint | `list(string)` | <pre>[<br>  "elasticsearch_username",<br>  "elasticsearch_password",<br>  "elasticsearch_https_endpoint"<br>]</pre> | no |
| metadata | Optional JSON-encoded string with metadata about the pipeline, such as a version number or the owner | `string` | `null` | no |
| on\_failure | Optional list of processors, each one a JSON-encoded string, to run when a processor in the pipeline fails | `list(string)` | `null` | no |
| pipeline\_name | Name of the ingest pipeline | `string` | n/a | yes |
| processors | List of processors, each one a JSON-encoded string. Build them with jsonencode(), e.g. jsonencode({ set = { field = "writeTime", value = "{{{\_ingest.timestamp}}}" } }) | `list(string)` | n/a | yes |
| project\_id | Project ID where Elastic secrets are stored | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Internal identifier of the resource |
| name | Name of the ingest pipeline. Pass it as default\_pipeline to the index module |
