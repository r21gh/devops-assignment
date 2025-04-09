locals {
  helm_chart_path = abspath("${path.module}/../../../helm-charts")

  # Environment-specific configurations
  env_config = {
    values_file             = "${local.helm_chart_path}/values.yaml"
    environment_values_file = "${local.helm_chart_path}/environments/values-${var.environment}.yaml"
  }
}