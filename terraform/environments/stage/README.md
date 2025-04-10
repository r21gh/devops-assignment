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
| <a name="input_api_base_url"></a> [api\_base\_url](#input\_api\_base\_url) | Base URL for the API | `string` | `"http://stage.flask-app.internal"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, stage, prod) | `string` | `"stage"` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Application log level | `string` | `"INFO"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace for the application | `string` | `"stage"` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Name of the Helm release | `string` | `"flask-app-release"` | no |
| <a name="input_replica_count"></a> [replica\_count](#input\_replica\_count) | Number of pod replicas | `number` | `2` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | Flask application secret key | `string` | n/a | yes |
| <a name="input_strategy_rolling_update_max_surge"></a> [strategy\_rolling\_update\_max\_surge](#input\_strategy\_rolling\_update\_max\_surge) | Maximum number of pods that can be created above the desired amount | `string` | `"25%"` | no |
| <a name="input_strategy_rolling_update_max_unavailable"></a> [strategy\_rolling\_update\_max\_unavailable](#input\_strategy\_rolling\_update\_max\_unavailable) | Maximum number of pods that can be unavailable during the update | `string` | `"25%"` | no |
| <a name="input_strategy_type"></a> [strategy\_type](#input\_strategy\_type) | Deployment strategy type | `string` | `"RollingUpdate"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_namespace"></a> [app\_namespace](#output\_app\_namespace) | The namespace where the application is deployed |
| <a name="output_app_release_name"></a> [app\_release\_name](#output\_app\_release\_name) | The name of the Helm release |
| <a name="output_app_release_revision"></a> [app\_release\_revision](#output\_app\_release\_revision) | The revision number of the release |
| <a name="output_app_release_status"></a> [app\_release\_status](#output\_app\_release\_status) | The status of the Helm release |
<!-- END_TF_DOCS -->