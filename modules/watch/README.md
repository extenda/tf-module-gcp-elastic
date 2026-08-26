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
| elastic\_secrets | List of secrets to extract from Secret Manager for Auth | `list(string)` | <pre>[<br>  "elasticsearch_username",<br>  "elasticsearch_password",<br>  "elasticsearch_https_endpoint"<br>]</pre> | no |
| project\_id | Project ID where Elastic secrets are stored | `string` | `""` | no |
| trigger  | The trigger that defines when the watch should run | `string` | n/a | yes |
| watch\_id  | Identifier for the watch | `string` | n/a | yes |
| actions | The list of actions that will be run if the condition matches | `string` | `null` | no |
| active | Defines whether the watch is active or inactive by default | `bool` | `true` | no |
| condition | The condition that defines if the actions should be run | `string` | `null` | no |
| input | The input that defines the input that loads the data for the watch | `string` | `null` | no |
| metadata | Metadata json that will be copied into the history entries | `string` | `null` | no |
| throttle\_period\_in\_millis | Minimum time in milliseconds between actions being run | `number` | `5000` | no |
| transform | Processes the watch payload to prepare it for the watch actions | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| watch | Internal identifier of the resource |
