// ──────────────────────────────────────────────
// Kubernetes Namespace for the Application
// ──────────────────────────────────────────────
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.namespace
    labels = {
      environment = var.environment
    }
  }
}

// ──────────────────────────────────────────────
// Kubernetes Secret: Sensitive Environment Variables
// ──────────────────────────────────────────────
resource "kubernetes_secret" "app_secrets" {
  metadata {
    name      = "${var.release_name}-${var.environment}-secrets"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/instance"   = "${var.release_name}-${var.environment}"
      "app.kubernetes.io/name"       = "flask-app"
    }
    annotations = {
      "meta.helm.sh/release-name"      = "${var.release_name}-${var.environment}"
      "meta.helm.sh/release-namespace" = var.namespace
    }
  }

  data = {
    SECRET_KEY  = var.secret_key
    DB_PASSWORD = var.db_password
  }

  type = "Opaque"

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [kubernetes_namespace.app_namespace]
  }
}

// ──────────────────────────────────────────────
// Kubernetes ConfigMap: Non-sensitive Configuration
// ──────────────────────────────────────────────
resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "${var.release_name}-${var.environment}-config"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
    labels = {
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/instance"   = "${var.release_name}-${var.environment}"
      "app.kubernetes.io/name"       = "flask-app"
    }
    annotations = {
      "meta.helm.sh/release-name"      = "${var.release_name}-${var.environment}"
      "meta.helm.sh/release-namespace" = var.namespace
    }
  }

  data = {
    API_BASE_URL    = var.api_base_url
    LOG_LEVEL       = var.log_level
    MAX_CONNECTIONS = var.max_connections
    ENVIRONMENT     = var.environment
  }

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [kubernetes_namespace.app_namespace]
  }
}

// ──────────────────────────────────────────────
// Helm Release: Deploy Flask Application
// ──────────────────────────────────────────────
resource "helm_release" "flask_app" {
  name      = "${var.release_name}-${var.environment}"
  chart     = var.chart_path
  version   = var.chart_version
  namespace = kubernetes_namespace.app_namespace.metadata[0].name

  atomic          = false               // Avoid rollback on failure
  replace         = true                // Replace release on conflict
  force_update    = true                // Force apply changes
  recreate_pods   = true                // Recreate pods on changes
  cleanup_on_fail = true                // Cleanup failed release
  timeout         = var.timeout_seconds // Configurable Helm timeout
  wait            = false               // Do not wait for resources
  wait_for_jobs   = false

  // Clean up previous ConfigMap and Secret before Helm install
  provisioner "local-exec" {
    when    = create
    command = <<-EOT
      kubectl delete secret -n ${kubernetes_namespace.app_namespace.metadata[0].name} ${var.release_name}-${var.environment}-secrets --ignore-not-found=true
      kubectl delete configmap -n ${kubernetes_namespace.app_namespace.metadata[0].name} ${var.release_name}-${var.environment}-config --ignore-not-found=true
    EOT
  }

  // Merge Helm values files
  values = [
    fileexists(var.values_file) ? file(var.values_file) : "",
    fileexists(var.environment_values_file) ? file(var.environment_values_file) : ""
  ]

  // Core application settings passed to Helm
  set {
    name  = "environment"
    value = var.environment
  }

  // Reference external ConfigMap and Secret as envFrom
  set {
    name  = "envFrom[0].configMapRef.name"
    value = kubernetes_config_map.app_config.metadata[0].name
  }

  set {
    name  = "envFrom[1].secretRef.name"
    value = kubernetes_secret.app_secrets.metadata[0].name
  }

  // Deployment strategy
  set {
    name  = "strategy.type"
    value = "RollingUpdate"
  }

  set {
    name  = "strategy.rollingUpdate.maxSurge"
    value = "50%"
  }

  set {
    name  = "strategy.rollingUpdate.maxUnavailable"
    value = "50%"
  }

  // Dynamic Helm values override
  dynamic "set" {
    for_each = var.extra_set_values
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    kubernetes_namespace.app_namespace,
    kubernetes_secret.app_secrets,
    kubernetes_config_map.app_config
  ]
}
