// ────────────────────────────────────────────────────────────────────────────
// Terraform Configuration: Provider and Backend Setup
// ────────────────────────────────────────────────────────────────────────────

terraform {
  required_version = ">= 1.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.2"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Helm and Kubernetes Providers: Configuration for Cluster Access
// ────────────────────────────────────────────────────────────────────────────

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
