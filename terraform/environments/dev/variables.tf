variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string
  default     = "dev"
}

variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
  default     = "dev"
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
  default     = "http://dev.flask-app.internal"
}

variable "log_level" {
  description = "Application log level"
  type        = string
  default     = "DEBUG"
}

variable "max_connections" {
  description = "Maximum number of database connections"
  type        = string
  default     = "50"
}

variable "replica_count" {
  description = "Number of pod replicas"
  type        = number
  default     = 1
} 