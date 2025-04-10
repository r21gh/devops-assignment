// ──────────────────────────────────────────────
// Terraform Outputs: Helm Deployment Metadata
// ──────────────────────────────────────────────

output "namespace" {
  description = "The Kubernetes namespace into which the application is deployed."
  value       = local.namespace
}

output "release_name" {
  description = "The fully qualified name assigned to the deployed Helm release (includes environment suffix)."
  value       = local.release_name
}

output "release_status" {
  description = "The current lifecycle status of the Helm release (e.g., deployed, failed, pending-upgrade)."
  value       = helm_release.flask_app.status
}

output "release_revision" {
  description = "The current revision number of the Helm release, automatically incremented with each upgrade or rollback."
  value       = helm_release.flask_app.version
}
