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

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

locals {
  helm_chart_path = abspath("${path.module}/../../../helm-charts")
}

module "flask_app" {
  source = "../../modules/helm-release"

  environment             = "stage"
  namespace               = "stage"
  release_name            = "flask-app-release"
  chart_path              = local.helm_chart_path
  values_file             = "${local.helm_chart_path}/values.yaml"
  environment_values_file = "${local.helm_chart_path}/environments/values-stage.yaml"

  # Sensitive environment variables
  secret_key  = var.secret_key
  db_password = var.db_password

  # Non-sensitive environment variables
  api_base_url    = "http://stage.flask-app.internal"
  log_level       = "INFO"
  max_connections = "100"

  extra_set_values = {
    "replicaCount"              = "2"
    "resources.requests.cpu"    = "100m"
    "resources.requests.memory" = "128Mi"
    "resources.limits.cpu"      = "200m"
    "resources.limits.memory"   = "256Mi"
  }
} 