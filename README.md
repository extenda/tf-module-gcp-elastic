# tf-module-gcp-elastic

## Description

This module creates Elastic Cloud deployment that consists of Elastic and Kibana clusters, and stores Secrets (username/password, url, etc) in the GCP project's Secret manager.

## Requirements

| Name | Version |
|------|---------|
| ec | 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| ec | 0.1.0 |
| google-beta | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deployment\_id | Deployment Template identifier to create the deployment from | `string` | `"gcp-io-optimized"` | no |
| elastic\_apikey | Elastic Cloud API key to extract from var.elastic\_project\_gcp\_secret | `string` | `"elastic-api-key"` | no |
| elastic\_insatnce\_config\_id | Instance Configuration ID from the deployment template | `string` | `"gcp.data.highio.1"` | no |
| elastic\_project\_gcp\_secret | GCP project ID having secret for Elastic Cloud credentials | `string` | `"tf-admin-90301274"` | no |
| elastic\_size | Amount of memory per node (GB) | `string` | `"4g"` | no |
| elastic\_version | Elastic Stack version to use for all of the deployment resources | `string` | `"7.9.3"` | no |
| elastic\_zone\_count | Number of zones that the Elasticsearch cluster will span. This is used to set HA | `number` | `1` | no |
| kibana\_insatnce\_config\_id | Instance Configuration ID from the deployment template | `string` | `"gcp.kibana.1"` | no |
| kibana\_size| Amount of memory per node (GB) | `string` | `"1g"` | no |
| kibana\_zone\_count | Number of zones that the Kibana cluster will span. This is used to set HA | `number` | `1` | no |
| name | The name for the deployment | `string` | n/a | yes |
| plugins | List of Elasticsearch supported plugins, which vary from version to version | `list` | `[""]` | no |
| project\_id | Project ID where Elastic secrets are stored | `string` | `""` | no |
| region | Region where to create the deployment | `string` | `"gcp-europe-west1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_id | The deployment identifier |
| elasticsearch\_cloud\_id | The encoded Elasticsearch credentials to use in Beats or Logstash |
| elasticsearch\_https\_endpoint | The Elasticsearch resource HTTPs endpoint |
| elasticsearch\_password | The auto-generated Elasticsearch password |
| elasticsearch\_username | The auto-generated Elasticsearch username |
| kibana\_https\_endpoint | The Kibana resource HTTPs endpoint |
