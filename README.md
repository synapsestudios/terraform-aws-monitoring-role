# AWS Monitoring Role

This module creates an IAM role and AWS EC2 Instance profile to be used with systems performing monitoring tasks. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.29 |
| aws | ~> 2.53 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.53 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tags | A mapping of tags to assign to the AWS resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_profile | The SynapseStudios Monitoring instance profileresource. |
| role | The SynapseStudios Monitoring role resource. |
| synapsestudios\_grafana\_key | AWS Access Key ID to be used with Grafana |
| synapsestudios\_grafana\_secret | AWS Access Key Secret to be used with Grafana |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->