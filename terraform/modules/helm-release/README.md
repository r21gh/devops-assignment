<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.25.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.25.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.flask_app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.app_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.app_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.app_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_base_url"></a> [api\_base\_url](#input\_api\_base\_url) | Base URL used by the application to connect to the API. | `string` | `"http://localhost:5000"` | no |
| <a name="input_chart_path"></a> [chart\_path](#input\_chart\_path) | Local or remote path to the Helm chart. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specific version of the Helm chart to deploy. Leave null to use the latest. | `string` | `null` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password used to connect to the application database. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Specifies the deployment environment (e.g., dev, stage, prod). | `string` | n/a | yes |
| <a name="input_environment_values_file"></a> [environment\_values\_file](#input\_environment\_values\_file) | Path to the environment-specific Helm values file. | `string` | n/a | yes |
| <a name="input_extra_set_values"></a> [extra\_set\_values](#input\_extra\_set\_values) | Map of additional key-value pairs to override Helm chart values. | `map(string)` | `{}` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level for the application (e.g., DEBUG, INFO, WARN, ERROR). | `string` | `"INFO"` | no |
| <a name="input_max_connections"></a> [max\_connections](#input\_max\_connections) | Maximum number of concurrent connections allowed by the application. | `string` | `"100"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace where the application will be deployed. | `string` | n/a | yes |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Unique name used to identify the Helm release. | `string` | `"flask-app-release"` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Secret key used for Flask session management and security. | `string` | n/a | yes |
| <a name="input_timeout_seconds"></a> [timeout\_seconds](#input\_timeout\_seconds) | Maximum time, in seconds, to wait for Helm operations to complete. | `number` | `300` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | Path to the base values.yaml file for Helm configuration. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The Kubernetes namespace into which the application is deployed. |
| <a name="output_release_name"></a> [release\_name](#output\_release\_name) | The name assigned to the deployed Helm release. |
| <a name="output_release_revision"></a> [release\_revision](#output\_release\_revision) | The revision number of the Helm release, incremented with each upgrade or rollback. |
| <a name="output_release_status"></a> [release\_status](#output\_release\_status) | The current status of the Helm release (e.g., deployed, failed). |
<!-- END_TF_DOCS -->