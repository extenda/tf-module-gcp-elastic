## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
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
| alias | Aliases for the index | `list(map(string))` | `null` | no |
| elastic\_secrets | List of secrets to extract from Secret Manager for Auth | `list(string)` | <pre>[<br>  "elasticsearch_username",<br>  "elasticsearch_password",<br>  "elasticsearch_https_endpoint"<br>]</pre> | no |
| index\_name | Name of the index to be created | `string` | n/a | yes |
| mappings | Mapping for fields in the index. If specified, this mapping can include: field names, field data types, mapping parameters | `string` | n/a | yes |
| number\_of\_replicas | Number of shard replicas | `number` | n/a | yes |
| number\_of\_routing\_shards | Value used with number\_of\_shards to route documents to a primary shard | `number` | `1` | no |
| number\_of\_shards | Number of shards for the index | `number` | n/a | yes |
| project\_id | Project ID where Elastic secrets are stored | `string` | `""` | no |
| refresh\_interval | How often to perform a refresh operation, which makes recent changes to the index visible to search. Can be set to -1 to disable refresh | `string` | `"1s"` | no |
| routing\_partition\_size | The number of shards a custom routing value can go to | `number` | `1` | no |
| search\_idle\_after | How long a shard can not receive a search or get request until it’s considered search idle | `string` | `"30s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Internal identifier of the resource |
| settings | All raw settings fetched from the cluster |
