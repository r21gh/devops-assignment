// ──────────────────────────────────────────────
// Terraform Configuration: Required Providers
// ──────────────────────────────────────────────
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    // Helm provider: Manages Helm chart deployments within Kubernetes clusters
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }

    // Kubernetes provider: Manages native Kubernetes resources (e.g., namespaces, services)
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.2"
    }

    // Null provider: Supports local-exec and other provisioners; useful for scripting
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.0"
    }
  }
}
