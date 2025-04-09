module "flask_app" {
  source = "../../modules/helm-release"

  environment             = var.environment
  namespace               = var.namespace
  release_name            = var.release_name
  chart_path              = local.helm_chart_path
  values_file             = local.env_config.values_file
  environment_values_file = local.env_config.environment_values_file

  # Sensitive environment variables
  secret_key  = var.secret_key
  db_password = var.db_password

  # Non-sensitive environment variables
  api_base_url    = var.api_base_url
  log_level       = var.log_level
  max_connections = var.max_connections
  extra_set_values = {
    "replicaCount" = var.replica_count
  }
} 