variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string
  default     = "stage"
}

variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
  default     = "stage"
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "flask-app-release"
}

variable "secret_key" {
  description = "Flask application secret key"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "api_base_url" {
  description = "Base URL for the API"
  type        = string
  default     = "http://stage.flask-app.internal"
}

variable "log_level" {
  description = "Application log level"
  type        = string
  default     = "INFO"
}

variable "replica_count" {
  description = "Number of pod replicas"
  type        = number
  default     = 2
}

variable "strategy_type" {
  description = "Deployment strategy type"
  type        = string
  default     = "RollingUpdate"
}

variable "strategy_rolling_update_max_surge" {
  description = "Maximum number of pods that can be created above the desired amount"
  type        = string
  default     = "25%"
}

variable "strategy_rolling_update_max_unavailable" {
  description = "Maximum number of pods that can be unavailable during the update"
  type        = string
  default     = "25%"
} 