// ──────────────────────────────────────────────
// Kubernetes Namespace for the Application
// ──────────────────────────────────────────────
resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = local.namespace
  }
}

// ──────────────────────────────────────────────
// Helm Release: Deploy Flask Application
// ──────────────────────────────────────────────
resource "helm_release" "flask_app" {
  name       = local.release_name
  chart      = var.chart_path
  version    = var.chart_version
  namespace  = local.namespace

  atomic          = var.atomic
  replace         = var.replace
  force_update    = var.force_update
  recreate_pods   = var.recreate_pods
  cleanup_on_fail = var.cleanup_on_fail
  timeout         = var.timeout_seconds
  wait            = var.wait
  wait_for_jobs   = var.wait_for_jobs

  values = local.helm_values

  // Core application settings
  set {
    name  = "environment"
    value = var.environment
  }

  set {
    name  = "config.secretKey"
    value = var.secret_key
  }

  set {
    name  = "config.dbPassword"
    value = var.db_password
  }

  set {
    name  = "config.apiBaseUrl"
    value = var.api_base_url
  }

  set {
    name  = "config.logLevel"
    value = var.log_level
  }

  set {
    name  = "strategy.type"
    value = var.strategy_type
  }

  set {
    name  = "strategy.rollingUpdate.maxSurge"
    value = var.strategy_rolling_update_max_surge
  }

  set {
    name  = "strategy.rollingUpdate.maxUnavailable"
    value = var.strategy_rolling_update_max_unavailable
  }

  set {
    name  = "config.maxConnections"
    value = var.max_connections
  }

  // Additional dynamic overrides
  dynamic "set" {
    for_each = var.extra_set_values
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    kubernetes_namespace.namespace
  ]
}