// ──────────────────────────────────────────────
// Terraform Configuration: Required Providers
// ──────────────────────────────────────────────
terraform {
  required_providers {
    // Helm provider to manage Helm charts in Kubernetes
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }

    // Kubernetes provider to interact with Kubernetes API objects
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.2"
    }
  }

  required_version = ">= 1.5.0"
}
