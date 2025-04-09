output "app_namespace" {
  description = "The namespace where the application is deployed"
  value       = module.flask_app.namespace
}

output "app_release_name" {
  description = "The name of the Helm release"
  value       = module.flask_app.release_name
}

output "app_release_status" {
  description = "The status of the Helm release"
  value       = module.flask_app.release_status
}

output "app_release_revision" {
  description = "The revision number of the release"
  value       = module.flask_app.release_revision
} 