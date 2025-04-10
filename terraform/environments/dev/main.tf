// ────────────────────────────────────────────────────────────────────────────────────
// Helm Release Module: Flask Application Deployment Configuration
// ────────────────────────────────────────────────────────────────────────────────────

module "flask_app" {
  source = "../../modules/helm-release"

  // ──────────────────────────────────────────────────────────────────────────────────
  // General Environment Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  environment             = local.environment
  namespace              = local.namespace
  release_name           = local.release_name
  create_namespace       = local.create_namespace

  // ──────────────────────────────────────────────────────────────────────────────────
  // Helm Chart Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  chart_path             = local.helm_chart_path
  values_file            = local.helm_config.values_file
  environment_values_file = local.helm_config.environment_values_file

  // ──────────────────────────────────────────────────────────────────────────────────
  // Sensitive Environment Variables
  // ──────────────────────────────────────────────────────────────────────────────────
  secret_key  = local.sensitive_env_vars.secret_key
  db_password = local.sensitive_env_vars.db_password

  // ──────────────────────────────────────────────────────────────────────────────────
  // Application Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  api_base_url    = local.app_config.api_base_url
  log_level       = local.app_config.log_level
  max_connections = local.app_config.max_connections

  // ──────────────────────────────────────────────────────────────────────────────────
  // Deployment Strategy Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  strategy_type                           = local.deployment_strategy.strategy_type
  strategy_rolling_update_max_surge       = local.deployment_strategy.strategy_rolling_update_max_surge
  strategy_rolling_update_max_unavailable = local.deployment_strategy.strategy_rolling_update_max_unavailable

  // ──────────────────────────────────────────────────────────────────────────────────
  // Helm Update Options
  // ──────────────────────────────────────────────────────────────────────────────────
  atomic          = local.helm_update_options.atomic
  replace         = local.helm_update_options.replace
  force_update    = local.helm_update_options.force_update
  recreate_pods   = local.helm_update_options.recreate_pods
  cleanup_on_fail = local.helm_update_options.cleanup_on_fail
  wait            = local.helm_update_options.wait
  wait_for_jobs   = local.helm_update_options.wait_for_jobs

  // ──────────────────────────────────────────────────────────────────────────────────
  // Additional Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  extra_set_values = {
    "replicaCount" = local.app_config.replica_count
  }
}