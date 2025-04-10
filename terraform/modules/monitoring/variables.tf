variable "namespace" {
  description = "The Kubernetes namespace to deploy monitoring stack"
  type        = string
}

variable "prometheus_values_file" {
  description = "Path to the Prometheus values file"
  type        = string
}

variable "grafana_values_file" {
  description = "Path to the Grafana values file"
  type        = string
} 