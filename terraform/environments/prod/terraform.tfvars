# Example values for sensitive variables - Production Environment
# Copy this file to terraform.tfvars and replace with actual values
# DO NOT commit terraform.tfvars to version control

environment                             = "prod"
namespace                               = "prod"
release_name                            = "flask-app-release"
api_base_url                            = "http://prod.flask-app.internal"
log_level                               = "WARN"
replica_count                           = 3
strategy_type                           = "RollingUpdate"
strategy_rolling_update_max_surge       = "25%"
strategy_rolling_update_max_unavailable = "25%"

# Note: secret_key and db_password should be provided via environment variables or secure secret management
# export TF_VAR_secret_key="your-secret-key"
# export TF_VAR_db_password="your-db-password"

secret_key  = "your-secure-secret-key-here"
db_password = "your-database-password-here" 