// ──────────────────────────────────────────────
// Terraform Outputs: Helm Deployment Metadata
// ──────────────────────────────────────────────

output "namespace" {
  description = "The Kubernetes namespace into which the application is deployed."
  value       = kubernetes_namespace.app_namespace.metadata[0].name
}

output "release_name" {
  description = "The name assigned to the deployed Helm release."
  value       = helm_release.flask_app.name
}

output "release_status" {
  description = "The current status of the Helm release (e.g., deployed, failed)."
  value       = helm_release.flask_app.status
}

output "release_revision" {
  description = "The revision number of the Helm release, incremented with each upgrade or rollback."
  value       = helm_release.flask_app.version
}
