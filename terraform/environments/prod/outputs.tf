// ────────────────────────────────────────────────────────────────────────────
// Output Values: Application Deployment Metadata
// ────────────────────────────────────────────────────────────────────────────

output "app_namespace" {
  description = "Indicates the Kubernetes namespace where the application has been deployed."
  value       = module.flask_app.namespace
}

output "app_release_name" {
  description = "The name of the Helm release associated with the application deployment."
  value       = module.flask_app.release_name
}

output "app_release_status" {
  description = "The current status of the Helm release, providing insights into the deployment state (e.g., deployed, failed)."
  value       = module.flask_app.release_status
}

output "app_release_revision" {
  description = "The revision number of the Helm release, indicating the version of the deployment."
  value       = module.flask_app.release_revision
}
