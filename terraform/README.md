# Terraform Configuration for Flask Application

This Terraform configuration manages the deployment of the Flask application using Helm charts in different environments.

## 📁 Directory Structure

```
terraform/
├── modules/
│   └── helm-release/         # Reusable module for Helm deployments
│       ├── main.tf          # Main module configuration
│       ├── variables.tf     # Module input variables
│       └── outputs.tf       # Module outputs
├── environments/
│   ├── dev/                 # Development environment
│   │   ├── main.tf         # Environment configuration
│   │   ├── variables.tf    # Environment variables
│   │   ├── outputs.tf      # Environment outputs
│   │   └── terraform.tfvars.example  # Example variables file
│   ├── stage/              # Staging environment
│   └── prod/               # Production environment
└── README.md               # This file
```

## 🔐 Environment Variables

The application uses both sensitive and non-sensitive environment variables:

### Sensitive Variables (Stored in Kubernetes Secrets)
- `SECRET_KEY`: Flask application secret key
- `DB_PASSWORD`: Database password

### Non-Sensitive Variables (Stored in ConfigMaps)
- `API_BASE_URL`: Base URL for the API
- `LOG_LEVEL`: Application log level
- `MAX_CONNECTIONS`: Maximum number of connections
- `ENVIRONMENT`: Current environment name

## 🚀 Quick Start

1. Set up environment variables:
```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your sensitive values
```

2. Initialize Terraform:
```bash
terraform init
```

3. Plan the deployment:
```bash
terraform plan
```

4. Apply the configuration:
```bash
terraform apply
```

## 🔧 Module Configuration

The `helm-release` module supports the following variables:

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| environment | Environment name | string | - |
| namespace | Kubernetes namespace | string | - |
| release_name | Helm release name | string | "flask-app-release" |
| chart_path | Path to Helm chart | string | - |
| values_file | Path to values.yaml | string | - |
| environment_values_file | Environment values file | string | - |
| secret_key | Flask secret key | string | - |
| db_password | Database password | string | - |
| api_base_url | API base URL | string | "http://localhost:5000" |
| log_level | Log level | string | "INFO" |
| max_connections | Max connections | string | "100" |
| timeout_seconds | Helm timeout | number | 300 |
| extra_set_values | Additional values | map | {} |

## 🌍 Environment-specific Configuration

### Development
```hcl
module "flask_app" {
  source = "../../modules/helm-release"
  
  # Environment settings
  environment = "dev"
  namespace  = "dev"
  
  # Sensitive variables
  secret_key  = var.secret_key
  db_password = var.db_password
  
  # Non-sensitive configuration
  api_base_url    = "http://dev.flask-app.internal"
  log_level       = "DEBUG"
  max_connections = "50"
}
```

## 📋 Available Outputs

- `app_namespace`: Deployed namespace
- `app_release_name`: Helm release name
- `app_release_status`: Release status
- `app_release_revision`: Release revision number

## 🔐 Security Considerations

1. Never commit `terraform.tfvars` to version control
2. Use Kubernetes secrets for sensitive data
3. Use ConfigMaps for non-sensitive configuration
4. Consider using external secrets management (e.g., HashiCorp Vault)
5. Use appropriate RBAC permissions
6. Encrypt state files if storing remotely

## 🤝 Contributing

1. Create environment-specific configurations
2. Test changes in dev first
3. Follow Terraform best practices
4. Update documentation
5. Don't commit sensitive data

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Helm Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)
- [Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
- [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/) 