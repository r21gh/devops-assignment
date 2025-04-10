// ──────────────────────────────────────────────
// Output Values: Application Deployment Metadata
// ──────────────────────────────────────────────

output "app_namespace" {
  description = "The Kubernetes namespace in which the application is deployed."
  value       = module.flask_app.namespace
}

output "app_release_name" {
  description = "The unique name assigned to the Helm release for the application."
  value       = module.flask_app.release_name
}

output "app_release_status" {
  description = "The current deployment status of the Helm release (e.g., deployed, failed)."
  value       = module.flask_app.release_status
}

output "app_release_revision" {
  description = "The revision number of the Helm release, which is incremented with each update or rollback."
  value       = module.flask_app.release_revision
}
