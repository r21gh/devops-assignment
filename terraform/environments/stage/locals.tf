// ────────────────────────────────────────────────────────────────────────────────────
// Local Configuration Values for Reusability and Consistency
// ────────────────────────────────────────────────────────────────────────────────────

locals {
  // ──────────────────────────────────────────────────────────────────────────────────
  // General Environment Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  environment      = var.environment
  namespace        = var.namespace
  release_name     = var.release_name
  create_namespace = var.create_namespace

  // ──────────────────────────────────────────────────────────────────────────────────
  // Helm Chart Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  helm_chart_path = abspath("${path.module}/../../../helm-charts")
  helm_config = {
    values_file             = "${local.helm_chart_path}/values.yaml"
    environment_values_file = "${local.helm_chart_path}/environments/values-${var.environment}.yaml"
  }

  // ──────────────────────────────────────────────────────────────────────────────────
  // Sensitive Environment Variables
  // ──────────────────────────────────────────────────────────────────────────────────
  sensitive_env_vars = {
    secret_key  = var.secret_key
    db_password = var.db_password
  }

  // ──────────────────────────────────────────────────────────────────────────────────
  // Application Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  app_config = {
    api_base_url    = var.api_base_url
    log_level       = var.log_level
    max_connections = var.max_connections
    replica_count   = var.replica_count
  }

  // ──────────────────────────────────────────────────────────────────────────────────
  // Deployment Strategy Configuration
  // ──────────────────────────────────────────────────────────────────────────────────
  deployment_strategy = {
    strategy_type                           = var.strategy_type
    strategy_rolling_update_max_surge       = var.strategy_rolling_update_max_surge
    strategy_rolling_update_max_unavailable = var.strategy_rolling_update_max_unavailable
  }

  // ──────────────────────────────────────────────────────────────────────────────────
  // Helm Update Options
  // ──────────────────────────────────────────────────────────────────────────────────
  helm_update_options = {
    atomic          = var.atomic
    replace         = var.replace
    force_update    = var.force_update
    recreate_pods   = var.recreate_pods
    cleanup_on_fail = var.cleanup_on_fail
    wait            = var.wait
    wait_for_jobs   = var.wait_for_jobs
  }
}