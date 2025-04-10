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
| <a name="input_api_base_url"></a> [api\_base\_url](#input\_api\_base\_url) | The base URL for the application API | `string` | `"http://dev.flask-app.internal"` | no |
| <a name="input_atomic"></a> [atomic](#input\_atomic) | Flag to specify whether to use atomic updates | `bool` | `false` | no |
| <a name="input_cleanup_on_fail"></a> [cleanup\_on\_fail](#input\_cleanup\_on\_fail) | Flag to specify whether to clean up resources if the operation fails | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Flag to specify whether to create a new Kubernetes namespace or use an existing one | `bool` | `true` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password used for the database connection | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (dev, stage, prod) | `string` | `"dev"` | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | Flag to specify whether to force the update of the Helm release | `bool` | `false` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The log level for the application (DEBUG, INFO, etc.) | `string` | `"DEBUG"` | no |
| <a name="input_max_connections"></a> [max\_connections](#input\_max\_connections) | Maximum number of connections allowed to the database | `number` | `100` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace where the application will be deployed | `string` | `"dev"` | no |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | Flag to specify whether to recreate the pods during the Helm upgrade | `bool` | `false` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | The name of the Helm release | `string` | `"flask-app-release"` | no |
| <a name="input_replace"></a> [replace](#input\_replace) | Flag to specify whether to replace the existing Helm release | `bool` | `false` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of pod replicas for scaling the application | `number` | `1` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Flask application secret key | `string` | n/a | yes |
| <a name="input_strategy_rolling_update_max_surge"></a> [strategy\_rolling\_update\_max\_surge](#input\_strategy\_rolling\_update\_max\_surge) | The maximum number of pods that can be created above the desired amount during a rolling update | `string` | `"25%"` | no |
| <a name="input_strategy_rolling_update_max_unavailable"></a> [strategy\_rolling\_update\_max\_unavailable](#input\_strategy\_rolling\_update\_max\_unavailable) | The maximum number of pods that can be unavailable during a rolling update | `string` | `"25%"` | no |
| <a name="input_strategy_type"></a> [strategy\_type](#input\_strategy\_type) | Deployment strategy for the Helm release (e.g., RollingUpdate, Recreate) | `string` | `"RollingUpdate"` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Flag to specify whether to wait for all resources to be ready after deployment | `bool` | `false` | no |
| <a name="input_wait_for_jobs"></a> [wait\_for\_jobs](#input\_wait\_for\_jobs) | Flag to specify whether to wait for jobs to complete before proceeding | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_namespace"></a> [app\_namespace](#output\_app\_namespace) | The Kubernetes namespace in which the application is deployed. |
| <a name="output_app_release_name"></a> [app\_release\_name](#output\_app\_release\_name) | The unique name assigned to the Helm release for the application. |
| <a name="output_app_release_revision"></a> [app\_release\_revision](#output\_app\_release\_revision) | The revision number of the Helm release, which is incremented with each update or rollback. |
| <a name="output_app_release_status"></a> [app\_release\_status](#output\_app\_release\_status) | The current deployment status of the Helm release (e.g., deployed, failed). |
<!-- END_TF_DOCS -->