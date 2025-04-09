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

  environment             = "prod"
  namespace               = "prod"
  release_name            = "flask-app-release"
  chart_path              = local.helm_chart_path
  values_file             = "${local.helm_chart_path}/values.yaml"
  environment_values_file = "${local.helm_chart_path}/environments/values-prod.yaml"

  # Sensitive environment variables
  secret_key  = var.secret_key
  db_password = var.db_password

  # Non-sensitive environment variables
  api_base_url    = "http://prod.flask-app.internal"
  log_level       = "WARN"
  max_connections = "500"

  extra_set_values = {
    "replicaCount"                               = "3"
    "resources.requests.cpu"                     = "500m"
    "resources.requests.memory"                  = "512Mi"
    "resources.limits.cpu"                       = "1000m"
    "resources.limits.memory"                    = "1Gi"
    "autoscaling.enabled"                        = "true"
    "autoscaling.minReplicas"                    = "3"
    "autoscaling.maxReplicas"                    = "10"
    "autoscaling.targetCPUUtilizationPercentage" = "80"
  }
} 