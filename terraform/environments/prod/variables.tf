// ────────────────────────────────────────────────────────────────────────────────────
// Terraform Variables Configuration: Environment, Application, and Deployment Settings
// ────────────────────────────────────────────────────────────────────────────────────

variable "environment" {
  description = "The environment name, e.g., 'dev', 'stage', or 'prod'."
  type        = string
  default     = "prod"
}

variable "namespace" {
  description = "The Kubernetes namespace in which the application will be deployed."
  type        = string
  default     = "prod"
}

variable "release_name" {
  description = "The name assigned to the Helm release for the application."
  type        = string
  default     = "flask-app-release"
}

// ────────────────────────────────────────────────────────────────────────────────────
// Sensitive Information: Application Configuration Secrets
// ────────────────────────────────────────────────────────────────────────────────────

variable "secret_key" {
  description = "The Flask application secret key used for cryptographic operations."
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the database used by the application."
  type        = string
  sensitive   = true
}

// ────────────────────────────────────────────────────────────────────────────────────
// Application Configuration: URLs, Logging, and Scaling Options
// ────────────────────────────────────────────────────────────────────────────────────

variable "api_base_url" {
  description = "The base URL for the Flask application API."
  type        = string
  default     = "http://prod.flask-app.internal"
}

variable "log_level" {
  description = "The log level for the application. Possible values are 'DEBUG', 'INFO', 'WARN', 'ERROR'."
  type        = string
  default     = "WARN"
}

variable "replica_count" {
  description = "The number of replicas for the Flask application pods in the Kubernetes cluster."
  type        = number
  default     = 3
}

// ────────────────────────────────────────────────────────────────────────────────────
// Deployment Strategy Configuration: Update and Rollback Settings
// ────────────────────────────────────────────────────────────────────────────────────

variable "strategy_type" {
  description = "The deployment strategy to use for Helm, e.g., 'RollingUpdate' or 'Recreate'."
  type        = string
  default     = "RollingUpdate"
}

variable "strategy_rolling_update_max_surge" {
  description = "Maximum number of pods that can be created above the desired count during a rolling update."
  type        = string
  default     = "25%"
}

variable "strategy_rolling_update_max_unavailable" {
  description = "Maximum number of pods that can be unavailable during the update process."
  type        = string
  default     = "25%"
}

// ────────────────────────────────────────────────────────────────────────────────────
// Database and Resource Limits: Connection Limits and Scaling Options
// ────────────────────────────────────────────────────────────────────────────────────

variable "max_connections" {
  description = "The maximum number of concurrent database connections allowed."
  type        = number
  default     = 100
}

// ────────────────────────────────────────────────────────────────────────────────────
// Kubernetes Namespace and Deployment Settings
// ────────────────────────────────────────────────────────────────────────────────────

variable "create_namespace" {
  description = "Flag indicating whether a new Kubernetes namespace should be created for the application."
  type        = bool
  default     = true
}

// ────────────────────────────────────────────────────────────────────────────────────
// Helm Deployment Settings: Atomic, Force Update, Recreate, and Cleanup Options
// ────────────────────────────────────────────────────────────────────────────────────

variable "atomic" {
  description = "Flag indicating whether to use atomic updates for Helm releases."
  type        = bool
  default     = false
}

variable "replace" {
  description = "Flag to determine if an existing Helm release should be replaced."
  type        = bool
  default     = false
}

variable "force_update" {
  description = "Flag to force an update of the Helm release, even if no changes are detected."
  type        = bool
  default     = false
}

variable "recreate_pods" {
  description = "Flag indicating whether the pods should be recreated during an update."
  type        = bool
  default     = false
}

variable "cleanup_on_fail" {
  description = "Flag indicating whether to clean up resources if the deployment fails."
  type        = bool
  default     = true
}

// ────────────────────────────────────────────────────────────────────────────────────
// Resource Waiting Options: Helm Wait for Resource Readiness and Job Completion
// ────────────────────────────────────────────────────────────────────────────────────

variable "wait" {
  description = "Flag indicating whether Terraform should wait for resources to be fully ready before proceeding."
  type        = bool
  default     = false
}

variable "wait_for_jobs" {
  description = "Flag indicating whether Terraform should wait for jobs to complete before proceeding with further steps."
  type        = bool
  default     = false
}
