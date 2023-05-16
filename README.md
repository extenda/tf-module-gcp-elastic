# tf-module-gcp-elastic

## Description

This module creates Elastic Cloud deployment that consists of Elastic and Kibana clusters, and stores Secrets (username/password, url, etc) in the GCP project's Secret manager.
## Requirements

| Name | Version |
|------|---------|
| ec | 0.5.0 |
| google | >= 4.28, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| ec | 0.5.0 |
| google | >= 4.28, < 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias | Deployment alias, affects the format of the resource URLs | `string` | `null` | no |
| apm\_debug | Enable debug mode for APM servers | `bool` | `false` | no |
| apm\_size | Amount of memory (RAM) per topology element in the XXg notation | `string` | `"1g"` | no |
| apm\_user\_settings\_json | JSON-formatted user level apm.yml setting overrides | `string` | `""` | no |
| apm\_user\_settings\_override\_json | JSON-formatted admin (ECE) level apm.yml setting overrides | `string` | `""` | no |
| apm\_zone\_count | Number of zones that the APM deployment will span. This is used to set HA | `number` | `1` | no |
| autoscale | Enable Elasticsearch autoscalling | `bool` | `false` | no |
| deployment\_template\_id | Deployment Template identifier to create the deployment from | `string` | `"gcp-io-optimized"` | no |
| elastic\_apikey | Elastic Cloud API key to extract from Secret Manager | `string` | `"elastic-api-key"` | no |
| elastic\_project\_gcp\_secret | GCP project ID which contains secret for Elastic Cloud credentials | `string` | `"tf-admin-90301274"` | no |
| elastic\_version | Elastic Stack version to use for all of the deployment resources | `string` | `"7.9.3"` | no |
| elasticsearch\_user\_settings\_json | JSON-formatted user level elasticsearch.yml setting overrides | `string` | `""` | no |
| elasticsearch\_user\_settings\_override\_json | JSON-formatted admin (ECE) level elasticsearch.yml setting overrides | `string` | `""` | no |
| enable\_apm | Whether to deploy APM to the cluster or not | `bool` | `false` | no |
| enable\_kibana | Whether to deploy Kibana or not | `bool` | `false` | no |
| kibana\_size | Amount of memory per node (GB) | `string` | `"1g"` | no |
| kibana\_user\_settings\_json | JSON-formatted user level kibana.yml setting overrides | `string` | `""` | no |
| kibana\_user\_settings\_override\_json | JSON-formatted admin (ECE) level kibana.yml setting overrides | `string` | `""` | no |
| kibana\_zone\_count | Number of zones that the Kibana cluster will span. This is used to set HA | `number` | `1` | no |
| name | The name for the deployment | `string` | n/a | yes |
| observability\_deployment\_id | Destination deployment ID for the shipped logs and monitoring metrics | `string` | `""` | no |
| observability\_enable\_logs | Enables or disables shipping logs | `bool` | `true` | no |
| observability\_enable\_metrics | Enables or disables shipping metrics | `bool` | `true` | no |
| plugins | List of Elasticsearch supported plugins, which vary from version to version | `list` | <pre>[<br>  ""<br>]</pre> | no |
| project\_id | Project ID where Elastic secrets are stored | `string` | `""` | no |
| region | Region where to create the deployment | `string` | `"gcp-europe-west1"` | no |
| tags | Key value map of arbitrary string tags | `map(string)` | `{}` | no |
| topology | Elasticsearch cluster topology list (see https://registry.terraform.io/providers/elastic/ec/latest/docs/resources/ec_deployment#topology) | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| apm\_https\_endpoint | APM resource HTTPs endpoint |
| apm\_secret\_token | Generated APM secret\_token |
| deployment\_id | The deployment identifier |
| elasticsearch\_cloud\_id | The encoded Elasticsearch credentials to use in Beats or Logstash |
| elasticsearch\_https\_endpoint | The Elasticsearch resource HTTPs endpoint |
| elasticsearch\_password | The auto-generated Elasticsearch password |
| elasticsearch\_username | The auto-generated Elasticsearch username |
| kibana\_https\_endpoint | The Kibana resource HTTPs endpoint |
