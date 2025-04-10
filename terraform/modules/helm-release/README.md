<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.25.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.0 |

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
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_base_url"></a> [api\_base\_url](#input\_api\_base\_url) | Base URL used by the application to connect to the API. | `string` | `"http://localhost:5000"` | no |
| <a name="input_atomic"></a> [atomic](#input\_atomic) | If true, installation process purges chart on failure. Set to ensure atomicity. | `bool` | `false` | no |
| <a name="input_chart_path"></a> [chart\_path](#input\_chart\_path) | Local or remote path to the Helm chart. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specific version of the Helm chart to deploy. Leave null to use the latest. | `string` | `null` | no |
| <a name="input_cleanup_on_fail"></a> [cleanup\_on\_fail](#input\_cleanup\_on\_fail) | If true, cleans up failed releases to avoid state pollution. | `bool` | `false` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create a new namespace or use an existing one. | `bool` | `false` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password used to connect to the application database. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Specifies the deployment environment (e.g., dev, stage, prod). | `string` | n/a | yes |
| <a name="input_environment_values_file"></a> [environment\_values\_file](#input\_environment\_values\_file) | Path to the environment-specific Helm values file. | `string` | n/a | yes |
| <a name="input_extra_set_values"></a> [extra\_set\_values](#input\_extra\_set\_values) | Map of additional key-value pairs to override Helm chart values. | `map(string)` | `{}` | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | If true, force resource updates through a delete and recreate strategy. | `bool` | `false` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level for the application (e.g., DEBUG, INFO, WARN, ERROR). | `string` | `"INFO"` | no |
| <a name="input_max_connections"></a> [max\_connections](#input\_max\_connections) | Maximum number of connections to the database. | `number` | `100` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace where the application will be deployed. | `string` | n/a | yes |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | If true, restarts pods if resource metadata changes. | `bool` | `false` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Unique name used to identify the Helm release. | `string` | `"flask-app-release"` | no |
| <a name="input_replace"></a> [replace](#input\_replace) | If true, replace the release if it already exists. | `bool` | `false` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Secret key used for Flask session management and security. | `string` | n/a | yes |
| <a name="input_strategy_rolling_update_max_surge"></a> [strategy\_rolling\_update\_max\_surge](#input\_strategy\_rolling\_update\_max\_surge) | Maximum number of pods that can be created above the desired amount. | `string` | `"25%"` | no |
| <a name="input_strategy_rolling_update_max_unavailable"></a> [strategy\_rolling\_update\_max\_unavailable](#input\_strategy\_rolling\_update\_max\_unavailable) | Maximum number of pods that can be unavailable during the update. | `string` | `"25%"` | no |
| <a name="input_strategy_type"></a> [strategy\_type](#input\_strategy\_type) | Deployment strategy type (e.g., RollingUpdate, Recreate). | `string` | `"RollingUpdate"` | no |
| <a name="input_timeout_seconds"></a> [timeout\_seconds](#input\_timeout\_seconds) | Maximum time, in seconds, to wait for Helm operations to complete. | `number` | `300` | no |
| <a name="input_values_file"></a> [values\_file](#input\_values\_file) | Path to the base values.yaml file for Helm configuration. | `string` | n/a | yes |
| <a name="input_wait"></a> [wait](#input\_wait) | If true, Terraform waits until all Helm resources are ready before continuing. | `bool` | `true` | no |
| <a name="input_wait_for_jobs"></a> [wait\_for\_jobs](#input\_wait\_for\_jobs) | If true, waits for all Kubernetes jobs to complete before marking the release successful. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The Kubernetes namespace into which the application is deployed. |
| <a name="output_release_name"></a> [release\_name](#output\_release\_name) | The fully qualified name assigned to the deployed Helm release (includes environment suffix). |
| <a name="output_release_revision"></a> [release\_revision](#output\_release\_revision) | The current revision number of the Helm release, automatically incremented with each upgrade or rollback. |
| <a name="output_release_status"></a> [release\_status](#output\_release\_status) | The current lifecycle status of the Helm release (e.g., deployed, failed, pending-upgrade). |
<!-- END_TF_DOCS -->