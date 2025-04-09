# Flask Application Helm Chart

This repository contains a Helm chart for deploying a Flask application to Kubernetes with environment-specific configurations.

## 📁 Directory Structure

```
helm-charts/
├── Chart.yaml           # Chart metadata and version information
├── values.yaml         # Default values for the chart
├── Taskfile.yml        # Task definitions for chart management
├── environments/       # Environment-specific value files
│   ├── values-dev.yaml
│   ├── values-stage.yaml
│   └── values-prod.yaml
├── templates/          # Kubernetes manifest templates
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── ...
└── charts/            # Dependencies (if any)
```

## 🚀 Quick Start

1. Install required tools:
   - [Task](https://taskfile.dev/#/installation)
   - [Helm](https://helm.sh/docs/intro/install/)
   - [kubectl](https://kubernetes.io/docs/tasks/tools/)

2. Create and switch to an environment:
   ```bash
   # Create a new environment
   task create-env -- dev

   # Switch to the environment
   task switch-env -- dev
   ```

## 🛠 Environment Management

### Creating and Managing Environments

```bash
# Create a new environment
task create-env -- dev
task create-env -- prod
task create-env -- stage

# Switch between environments
task switch-env -- dev
task switch-env -- prod

# Get environment information
task get-env            # Shows current environment
task get-env -- dev    # Shows specific environment details
```

### Chart Installation and Management

```bash
# Install/Upgrade the chart in an environment
task install -- dev
task install -- prod

# Uninstall from an environment
task uninstall -- dev

# List releases
task get-releases -- all     # All environments
task get-releases -- dev     # Specific environment

# Check release values
task values -- dev
```

### Deployment Status and Debugging

```bash
# Check deployment status
task status -- dev

# Wait for pods to be ready
task wait-ready -- dev

# Debug deployment issues
task debug -- dev

# View release history
task history -- dev
```

### Development and Testing

```bash
# Lint the chart
task lint

# Template the chart (preview manifests)
task template -- dev
task template-output -- dev    # Save to file

# Run tests
task test -- dev

# Package the chart
task build -- dev
```

## 🌍 Environment Configuration

### Environment-Specific Values

Each environment can have its own configuration in `environments/values-{env}.yaml`:

- `environments/values-dev.yaml`: Development environment settings
- `environments/values-stage.yaml`: Staging environment settings
- `environments/values-prod.yaml`: Production environment settings

### Default Values

The `values.yaml` file contains default configurations that can be overridden by environment-specific values:

```yaml
environment: dev
replicaCount: 1
image:
  repository: ghcr.io/r21gh/flask-app
  tag: latest
```

## 📋 Task Reference

| Task | Description | Usage |
|------|-------------|-------|
| `create-env` | Create a new environment | `task create-env -- <env>` |
| `switch-env` | Switch to an environment | `task switch-env -- <env>` |
| `get-env` | Show environment info | `task get-env -- [env]` |
| `install` | Install/upgrade release | `task install -- <env>` |
| `uninstall` | Remove release | `task uninstall -- <env>` |
| `status` | Check deployment status | `task status -- <env>` |
| `debug` | Show debugging info | `task debug -- <env>` |
| `template` | Preview manifests | `task template -- <env>` |
| `test` | Run Helm tests | `task test -- <env>` |
| `values` | Show computed values | `task values -- <env>` |
| `get-releases` | List releases | `task get-releases -- <env>` |

## 🔄 Common Workflows

### Initial Deployment
```bash
# Create and switch to dev environment
task create-env -- dev
task switch-env -- dev

# Install the application
task install -- dev

# Wait for deployment and check status
task wait-ready -- dev
task status -- dev
```

### Updating the Application
```bash
# Update in dev first
task upgrade -- dev
task wait-ready -- dev
task status -- dev

# After testing, update production
task upgrade -- prod
task wait-ready -- prod
task status -- prod
```

### Troubleshooting
```bash
# Check deployment status
task status -- dev

# Get detailed debugging information
task debug -- dev

# View logs and events
task status -- dev

# Check release values
task values -- dev
```

## 🔐 Security Considerations

1. Sensitive data should be managed through Kubernetes secrets
2. Environment-specific values files should not contain sensitive data
3. Use appropriate RBAC permissions for different environments
4. Consider using sealed secrets for sensitive data in Git

## 📝 Best Practices

1. Always test changes in dev/stage before prod
2. Use semantic versioning for chart versions
3. Document environment-specific configurations
4. Regularly update dependencies
5. Keep value files DRY using the base `values.yaml`

## 🤝 Contributing

1. Create environment-specific values in `environments/`
2. Test changes using the provided tasks
3. Update documentation as needed
4. Follow Helm best practices

## 📚 Additional Resources

- [Helm Documentation](https://helm.sh/docs/)
- [Taskfile Documentation](https://taskfile.dev/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
