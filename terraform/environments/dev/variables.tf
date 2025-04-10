// ──────────────────────────────────────────────
// Terraform Variables for Helm Deployment
// ──────────────────────────────────────────────

variable "environment" {
  description = "The environment name (dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "namespace" {
  description = "The Kubernetes namespace where the application will be deployed"
  type        = string
  default     = "dev"
}

variable "release_name" {
  description = "The name of the Helm release"
  type        = string
  default     = "flask-app-release"
}

variable "secret_key" {
  description = "Flask application secret key"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password used for the database connection"
  type        = string
  sensitive   = true
}

variable "api_base_url" {
  description = "The base URL for the application API"
  type        = string
  default     = "http://dev.flask-app.internal"
}

variable "log_level" {
  description = "The log level for the application (DEBUG, INFO, etc.)"
  type        = string
  default     = "DEBUG"
}

variable "replica_count" {
  description = "Number of pod replicas for scaling the application"
  type        = number
  default     = 1
}

variable "strategy_type" {
  description = "Deployment strategy for the Helm release (e.g., RollingUpdate, Recreate)"
  type        = string
  default     = "RollingUpdate"
}

variable "strategy_rolling_update_max_surge" {
  description = "The maximum number of pods that can be created above the desired amount during a rolling update"
  type        = string
  default     = "25%"
}

variable "strategy_rolling_update_max_unavailable" {
  description = "The maximum number of pods that can be unavailable during a rolling update"
  type        = string
  default     = "25%"
}

variable "max_connections" {
  description = "Maximum number of connections allowed to the database"
  type        = number
  default     = 100
}

variable "create_namespace" {
  description = "Flag to specify whether to create a new Kubernetes namespace or use an existing one"
  type        = bool
  default     = true
}

variable "atomic" {
  description = "Flag to specify whether to use atomic updates"
  type        = bool
  default     = false
}

variable "replace" {
  description = "Flag to specify whether to replace the existing Helm release"
  type        = bool
  default     = false
}

variable "force_update" {
  description = "Flag to specify whether to force the update of the Helm release"
  type        = bool
  default     = false
}

variable "recreate_pods" {
  description = "Flag to specify whether to recreate the pods during the Helm upgrade"
  type        = bool
  default     = false
}

variable "cleanup_on_fail" {
  description = "Flag to specify whether to clean up resources if the operation fails"
  type        = bool
  default     = true
}

variable "wait" {
  description = "Flag to specify whether to wait for all resources to be ready after deployment"
  type        = bool
  default     = false
}

variable "wait_for_jobs" {
  description = "Flag to specify whether to wait for jobs to complete before proceeding"
  type        = bool
  default     = false
}
