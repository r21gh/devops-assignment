// ──────────────────────────────────────────────
// Terraform Configuration: Providers and Backend
// ──────────────────────────────────────────────

terraform {
  // Required Terraform version
  required_version = ">= 1.0"

  // Specifying required providers
  required_providers {
    // Helm provider to manage Helm charts in Kubernetes
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }

    // Kubernetes provider to interact with the Kubernetes API
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.2"
    }
  }

  // Backend configuration: Store Terraform state locally
  backend "local" {
    path = "terraform.tfstate"
  }
}

// ──────────────────────────────────────────────
// Provider Configuration: Helm and Kubernetes
// ──────────────────────────────────────────────

provider "helm" {
  kubernetes {
    // Path to Kubernetes configuration file
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  // Path to Kubernetes configuration file
  config_path = "~/.kube/config"
}
