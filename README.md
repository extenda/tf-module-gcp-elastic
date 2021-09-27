# tf-module-gcp-elastic

## Description

This module creates Elastic Cloud deployment that consists of Elastic and Kibana clusters, and stores Secrets (username/password, url, etc) in the GCP project's Secret manager.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ec"></a> [ec](#requirement\_ec) | 0.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ec"></a> [ec](#provider\_ec) | 0.2.1 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ec_deployment.deployment](https://registry.terraform.io/providers/elastic/ec/0.2.1/docs/resources/deployment) | resource |
| [google-beta_google_secret_manager_secret.elastic_secret_id](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_secret_manager_secret) | resource |
| [google-beta_google_secret_manager_secret_version.elastic_secret_value](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_secret_manager_secret_version) | resource |
| [google-beta_google_secret_manager_secret_version.elastic_secret](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_secret_manager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apm_debug"></a> [apm\_debug](#input\_apm\_debug) | Enable debug mode for APM servers | `bool` | `false` | no |
| <a name="input_apm_size"></a> [apm\_size](#input\_apm\_size) | Amount of memory (RAM) per topology element in the XXg notation | `string` | `"1g"` | no |
| <a name="input_apm_user_settings_json"></a> [apm\_user\_settings\_json](#input\_apm\_user\_settings\_json) | JSON-formatted user level apm.yml setting overrides | `string` | `""` | no |
| <a name="input_apm_user_settings_override_json"></a> [apm\_user\_settings\_override\_json](#input\_apm\_user\_settings\_override\_json) | JSON-formatted admin (ECE) level apm.yml setting overrides | `string` | `""` | no |
| <a name="input_apm_zone_count"></a> [apm\_zone\_count](#input\_apm\_zone\_count) | Number of zones that the APM deployment will span. This is used to set HA | `number` | `1` | no |
| <a name="input_autoscale"></a> [autoscale](#input\_autoscale) | Enable Elasticsearch autoscalling | `bool` | `false` | no |
| <a name="input_deployment_id"></a> [deployment\_id](#input\_deployment\_id) | Deployment Template identifier to create the deployment from | `string` | `"gcp-io-optimized"` | no |
| <a name="input_elastic_apikey"></a> [elastic\_apikey](#input\_elastic\_apikey) | Elastic Cloud API key to extract from var.elastic\_project\_gcp\_secret | `string` | `"elastic-api-key"` | no |
| <a name="input_elastic_insatnce_config_id"></a> [elastic\_insatnce\_config\_id](#input\_elastic\_insatnce\_config\_id) | Instance Configuration ID from the deployment template | `string` | `"gcp.data.highio.1"` | no |
| <a name="input_elastic_project_gcp_secret"></a> [elastic\_project\_gcp\_secret](#input\_elastic\_project\_gcp\_secret) | GCP project ID having secret for Elastic Cloud credentials | `string` | `"tf-admin-90301274"` | no |
| <a name="input_elastic_version"></a> [elastic\_version](#input\_elastic\_version) | Elastic Stack version to use for all of the deployment resources | `string` | `"7.9.3"` | no |
| <a name="input_elasticsearch_user_settings_json"></a> [elasticsearch\_user\_settings\_json](#input\_elasticsearch\_user\_settings\_json) | JSON-formatted user level elasticsearch.yml setting overrides | `string` | `""` | no |
| <a name="input_elasticsearch_user_settings_override_json"></a> [elasticsearch\_user\_settings\_override\_json](#input\_elasticsearch\_user\_settings\_override\_json) | JSON-formatted admin (ECE) level elasticsearch.yml setting overrides | `string` | `""` | no |
| <a name="input_enable_apm"></a> [enable\_apm](#input\_enable\_apm) | Deploy APM to the cluster or not | `bool` | `false` | no |
| <a name="input_enable_kibana"></a> [enable\_kibana](#input\_enable\_kibana) | Deploy Kibana or not | `bool` | `false` | no |
| <a name="input_kibana_size"></a> [kibana\_size](#input\_kibana\_size) | Amount of memory per node (GB) | `string` | `"1g"` | no |
| <a name="input_kibana_user_settings_json"></a> [kibana\_user\_settings\_json](#input\_kibana\_user\_settings\_json) | JSON-formatted user level kibana.yml setting overrides | `string` | `""` | no |
| <a name="input_kibana_user_settings_override_json"></a> [kibana\_user\_settings\_override\_json](#input\_kibana\_user\_settings\_override\_json) | JSON-formatted admin (ECE) level kibana.yml setting overrides | `string` | `""` | no |
| <a name="input_kibana_zone_count"></a> [kibana\_zone\_count](#input\_kibana\_zone\_count) | Number of zones that the Kibana cluster will span. This is used to set HA | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the deployment | `string` | n/a | yes |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | List of Elasticsearch supported plugins, which vary from version to version | `list` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where Elastic secrets are stored | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where to create the deployment | `string` | `"gcp-europe-west1"` | no |
| <a name="input_topology"></a> [topology](#input\_topology) | Elasticsearch cluster topology | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apm_https_endpoint"></a> [apm\_https\_endpoint](#output\_apm\_https\_endpoint) | APM resource HTTPs endpoint |
| <a name="output_deployment_id"></a> [deployment\_id](#output\_deployment\_id) | The deployment identifier |
| <a name="output_elasticsearch_cloud_id"></a> [elasticsearch\_cloud\_id](#output\_elasticsearch\_cloud\_id) | The encoded Elasticsearch credentials to use in Beats or Logstash |
| <a name="output_elasticsearch_https_endpoint"></a> [elasticsearch\_https\_endpoint](#output\_elasticsearch\_https\_endpoint) | The Elasticsearch resource HTTPs endpoint |
| <a name="output_elasticsearch_password"></a> [elasticsearch\_password](#output\_elasticsearch\_password) | The auto-generated Elasticsearch password |
| <a name="output_elasticsearch_username"></a> [elasticsearch\_username](#output\_elasticsearch\_username) | The auto-generated Elasticsearch username |
| <a name="output_kibana_https_endpoint"></a> [kibana\_https\_endpoint](#output\_kibana\_https\_endpoint) | The Kibana resource HTTPs endpoint |
