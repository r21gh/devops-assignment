<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.25.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flask_app"></a> [flask\_app](#module\_flask\_app) | ../../modules/helm-release | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_base_url"></a> [api\_base\_url](#input\_api\_base\_url) | The base URL for the Flask application API. | `string` | `"http://prod.flask-app.internal"` | no |
| <a name="input_atomic"></a> [atomic](#input\_atomic) | Flag indicating whether to use atomic updates for Helm releases. | `bool` | `false` | no |
| <a name="input_cleanup_on_fail"></a> [cleanup\_on\_fail](#input\_cleanup\_on\_fail) | Flag indicating whether to clean up resources if the deployment fails. | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Flag indicating whether a new Kubernetes namespace should be created for the application. | `bool` | `true` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the database used by the application. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name, e.g., 'dev', 'stage', or 'prod'. | `string` | `"prod"` | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | Flag to force an update of the Helm release, even if no changes are detected. | `bool` | `false` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The log level for the application. Possible values are 'DEBUG', 'INFO', 'WARN', 'ERROR'. | `string` | `"WARN"` | no |
| <a name="input_max_connections"></a> [max\_connections](#input\_max\_connections) | The maximum number of concurrent database connections allowed. | `number` | `100` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace in which the application will be deployed. | `string` | `"prod"` | no |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | Flag indicating whether the pods should be recreated during an update. | `bool` | `false` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | The name assigned to the Helm release for the application. | `string` | `"flask-app-release"` | no |
| <a name="input_replace"></a> [replace](#input\_replace) | Flag to determine if an existing Helm release should be replaced. | `bool` | `false` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | The number of replicas for the Flask application pods in the Kubernetes cluster. | `number` | `3` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | The Flask application secret key used for cryptographic operations. | `string` | n/a | yes |
| <a name="input_strategy_rolling_update_max_surge"></a> [strategy\_rolling\_update\_max\_surge](#input\_strategy\_rolling\_update\_max\_surge) | Maximum number of pods that can be created above the desired count during a rolling update. | `string` | `"25%"` | no |
| <a name="input_strategy_rolling_update_max_unavailable"></a> [strategy\_rolling\_update\_max\_unavailable](#input\_strategy\_rolling\_update\_max\_unavailable) | Maximum number of pods that can be unavailable during the update process. | `string` | `"25%"` | no |
| <a name="input_strategy_type"></a> [strategy\_type](#input\_strategy\_type) | The deployment strategy to use for Helm, e.g., 'RollingUpdate' or 'Recreate'. | `string` | `"RollingUpdate"` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Flag indicating whether Terraform should wait for resources to be fully ready before proceeding. | `bool` | `false` | no |
| <a name="input_wait_for_jobs"></a> [wait\_for\_jobs](#input\_wait\_for\_jobs) | Flag indicating whether Terraform should wait for jobs to complete before proceeding with further steps. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_namespace"></a> [app\_namespace](#output\_app\_namespace) | Indicates the Kubernetes namespace where the application has been deployed. |
| <a name="output_app_release_name"></a> [app\_release\_name](#output\_app\_release\_name) | The name of the Helm release associated with the application deployment. |
| <a name="output_app_release_revision"></a> [app\_release\_revision](#output\_app\_release\_revision) | The revision number of the Helm release, indicating the version of the deployment. |
| <a name="output_app_release_status"></a> [app\_release\_status](#output\_app\_release\_status) | The current status of the Helm release, providing insights into the deployment state (e.g., deployed, failed). |
<!-- END_TF_DOCS -->