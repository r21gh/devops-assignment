// ──────────────────────────────────────────────
// Deployment Metadata
// ──────────────────────────────────────────────

variable "environment" {
  description = "Specifies the deployment environment (e.g., dev, stage, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], lower(var.environment))
    error_message = "Environment must be one of: dev, stage, prod."
  }
}

variable "namespace" {
  description = "Kubernetes namespace where the application will be deployed."
  type        = string

  validation {
    condition     = length(trimspace(var.namespace)) > 0
    error_message = "Namespace must not be empty."
  }
}

variable "release_name" {
  description = "Unique name used to identify the Helm release."
  type        = string
  default     = "flask-app-release"
}

variable "create_namespace" {
  description = "Whether to create a new namespace or use an existing one."
  type        = bool
  default     = false
}

// ──────────────────────────────────────────────
// Helm Chart Configuration
// ──────────────────────────────────────────────

variable "chart_path" {
  description = "Local or remote path to the Helm chart."
  type        = string

  validation {
    condition     = length(trimspace(var.chart_path)) > 0
    error_message = "Chart path must not be empty."
  }
}

variable "chart_version" {
  description = "Specific version of the Helm chart to deploy. Leave null to use the latest."
  type        = string
  default     = null
}

variable "values_file" {
  description = "Path to the base values.yaml file for Helm configuration."
  type        = string

  validation {
    condition     = length(trimspace(var.values_file)) > 0
    error_message = "Values file path must not be empty."
  }
}

variable "environment_values_file" {
  description = "Path to the environment-specific Helm values file."
  type        = string

  validation {
    condition     = length(trimspace(var.environment_values_file)) > 0
    error_message = "Environment-specific values file path must not be empty."
  }
}

variable "timeout_seconds" {
  description = "Maximum time, in seconds, to wait for Helm operations to complete."
  type        = number
  default     = 300

  validation {
    condition     = var.timeout_seconds > 0
    error_message = "Timeout must be a positive number."
  }
}

// ──────────────────────────────────────────────
// Application Secrets (Sensitive)
// ──────────────────────────────────────────────

variable "secret_key" {
  description = "Secret key used for Flask session management and security."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.secret_key)) > 0
    error_message = "Secret key must not be empty."
  }
}

variable "db_password" {
  description = "Password used to connect to the application database."
  type        = string
  sensitive   = true

  validation {
    condition     = length(trimspace(var.db_password)) > 0
    error_message = "Database password must not be empty."
  }
}

// ──────────────────────────────────────────────
// Application Settings (Non-Sensitive)
// ──────────────────────────────────────────────

variable "api_base_url" {
  description = "Base URL used by the application to connect to the API."
  type        = string
  default     = "http://localhost:5000"

  validation {
    condition     = can(regex("^https?://", var.api_base_url))
    error_message = "API base URL must start with http:// or https://."
  }
}

variable "log_level" {
  description = "Log level for the application (e.g., DEBUG, INFO, WARN, ERROR)."
  type        = string
  default     = "INFO"

  validation {
    condition     = contains(["DEBUG", "INFO", "WARN", "ERROR"], upper(var.log_level))
    error_message = "Log level must be one of: DEBUG, INFO, WARN, ERROR."
  }
}

variable "strategy_type" {
  description = "Deployment strategy type (e.g., RollingUpdate, Recreate)."
  type        = string
  default     = "RollingUpdate"
}

variable "strategy_rolling_update_max_surge" {
  description = "Maximum number of pods that can be created above the desired amount."
  type        = string
  default     = "25%"
}

variable "strategy_rolling_update_max_unavailable" {
  description = "Maximum number of pods that can be unavailable during the update."
  type        = string
  default     = "25%"
}

variable "extra_set_values" {
  description = "Map of additional key-value pairs to override Helm chart values."
  type        = map(string)
  default     = {}
}

variable "max_connections" {
  description = "Maximum number of connections to the database."
  type        = number
  default     = 100
}

// ──────────────────────────────────────────────
// Helm Behavior Flags
// ──────────────────────────────────────────────

variable "atomic" {
  description = "If true, installation process purges chart on failure. Set to ensure atomicity."
  type        = bool
  default     = false
}

variable "replace" {
  description = "If true, replace the release if it already exists."
  type        = bool
  default     = false
}

variable "force_update" {
  description = "If true, force resource updates through a delete and recreate strategy."
  type        = bool
  default     = false
}

variable "recreate_pods" {
  description = "If true, restarts pods if resource metadata changes."
  type        = bool
  default     = false
}

variable "cleanup_on_fail" {
  description = "If true, cleans up failed releases to avoid state pollution."
  type        = bool
  default     = false
}

variable "wait" {
  description = "If true, Terraform waits until all Helm resources are ready before continuing."
  type        = bool
  default     = true
}

variable "wait_for_jobs" {
  description = "If true, waits for all Kubernetes jobs to complete before marking the release successful."
  type        = bool
  default     = true
}
