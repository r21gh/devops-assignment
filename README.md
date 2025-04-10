# DevOps Infrastructure Assignment

This repository contains an infrastructure-as-code solution for deploying and managing applications on AWS using Terraform, Helm, and Task automation.

## Table of Contents
- [Architecture Overview](#architecture-overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Deployment Guide](#deployment-guide)
- [Infrastructure Design Decisions](#infrastructure-design-decisions)
- [Networking Strategy](#networking-strategy)
- [Security and Access Management](#security-and-access-management)
- [CI/CD Implementation](#cicd-implementation)
- [Solution Components](#solution-components)
- [Future Enhancements](#future-enhancements)

## Architecture Overview

The solution implements a modern cloud-native architecture with the following key components:

- EKS-based Kubernetes cluster for container orchestration
- Multi-environment support (staging, production)
- Automated infrastructure deployment using Terraform
- Helm-based application deployment
- Comprehensive monitoring and logging setup

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0.0
- Task (go-task) for automation
- kubectl
- helm
- terraform-docs
- tflint

## Getting Started

1. Install required tools:
```bash
task setup
```

2. Initialize the infrastructure:
```bash
task infra:init ENV=stage  # or ENV=prod
```

## Deployment Guide

1. Plan the changes:
```bash
task infra:plan ENV=stage
```

2. Apply the infrastructure:
```bash
task infra:apply ENV=stage
```

3. Verify deployment:
- Check AWS Console for resource creation
- Verify EKS cluster status
- Confirm application endpoints are accessible
- Monitor CloudWatch logs

## Infrastructure Design Decisions

### Kubernetes (EKS)
- **Why EKS?** Managed Kubernetes service reducing operational overhead
- **Node Groups:** Mix of on-demand and spot instances for cost optimization
- **Auto-scaling:** Implemented at both cluster and pod level

### Storage
- EBS for persistent workloads
- S3 for static assets and backups
- EFS for shared filesystem requirements

### Monitoring
- CloudWatch for logs and metrics
- AWS X-Ray for distributed tracing

## Networking Strategy

### VPC Design
- Multi-AZ deployment for high availability
- Private subnets for workload isolation
- Public subnets for load balancers
- NAT Gateways for outbound internet access

### Security Groups
- Layered security approach
- Principle of least privilege
- Separate security groups for different components

### Load Balancing
- Application Load Balancer (ALB) for HTTP/HTTPS traffic
- Network Load Balancer (NLB) for TCP/UDP workloads
- AWS Global Accelerator for global routing optimization

## Security and Access Management

### IAM Strategy
- Pod IAM roles using IRSA (IAM Roles for Service Accounts)
- Least privilege access principles
- Regular key rotation
- AWS Secrets Manager for sensitive data

### Network Security
- VPC Flow Logs enabled
- AWS WAF for web application protection
- AWS Shield for DDoS protection
- Private endpoints for AWS services

## CI/CD Implementation

### Pipeline Structure
1. **Build Stage**
   - Code validation
   - Unit tests
   - Container image building
   - Security scanning

2. **Infrastructure Stage**
   - Terraform plan/apply
   - Configuration validation
   - Infrastructure tests

3. **Deployment Stage**
   - Helm chart deployment
   - Smoke tests
   - Integration tests

### Environment Promotion
- Staging environment for testing
- Production deployment after approval
- Automated rollback capabilities

## Solution Components

### Scalability
- Horizontal pod autoscaling
- Cluster autoscaling
- Application-level caching
- CDN integration

### High Availability
- Multi-AZ deployment
- Pod anti-affinity rules
- Regular backup strategy
- Disaster recovery plan

### Fault Tolerance
- Circuit breakers
- Retry mechanisms
- Graceful degradation
- Health checks and self-healing

## Future Enhancements

1. **Technical Improvements**
   - Service mesh implementation
   - GitOps workflow
   - Blue-green deployments
   - Chaos engineering practices

2. **Operational Improvements**
   - Cost optimization
   - Enhanced monitoring
   - Automated compliance checks
   - Performance optimization

3. **Security Enhancements**
   - Zero trust architecture
   - Enhanced audit logging
   - Automated security scanning
   - Compliance automation

## Trade-offs Considered

1. **Managed vs. Self-hosted Services**
   - Chose managed services (EKS, RDS) for reduced operational overhead
   - Trade-off: Higher costs but lower maintenance burden

2. **Multi-AZ vs. Single-AZ**
   - Implemented Multi-AZ for high availability
   - Trade-off: Increased costs but better reliability

3. **Spot vs. On-demand Instances**
   - Mixed usage for cost optimization
   - Trade-off: Some complexity in handling spot terminations

4. **Monitoring Granularity**
   - Comprehensive monitoring with associated costs
   - Trade-off: Storage costs vs. debugging capability

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Features:
- Flask application with health check and configuration endpoints
- Helm chart for Kubernetes deployment
- Terraform configuration for infrastructure management
- Environment-specific configurations 

# Flask App Kubernetes Deployment Guide

This guide explains how to deploy a Flask application on Kubernetes using NodePort service.

## Prerequisites

- Docker Desktop with Kubernetes enabled
- Minikube installed
- kubectl CLI
- Helm v3

## Project Structure

```
.
├── app/
│   ├── app.py              # Flask application
│   └── requirements.txt    # Python dependencies
├── helm-charts/            # Helm chart for Kubernetes deployment
│   ├── templates/          # Kubernetes manifest templates
│   ├── Chart.yaml         # Chart metadata
│   └── values.yaml        # Configuration values
└── Dockerfile             # Container image definition
```

## Application Details

The Flask application serves a simple HTML page with a welcome message. It's containerized using Docker and deployed to Kubernetes using Helm.

### Key Features:
- Simple HTML interface
- Health check endpoint
- Configuration via environment variables
- Logging middleware

## Deployment Steps

1. **Build and Push Docker Image**
   ```bash
   docker build -t r21gh/flask-app:latest .
   docker push r21gh/flask-app:latest
   ```

2. **Deploy to Kubernetes using Helm**
   ```bash
   # Create namespace
   kubectl create namespace dev

   # Install Helm chart
   helm install flask-app-release-dev ./helm-charts -n dev
   ```

3. **Verify Deployment**
   ```bash
   # Check pods and services
   kubectl get pods,svc -n dev
   ```

   Expected output:
   ```
   NAME                                         READY   STATUS    RESTARTS   AGE
   pod/flask-app-release-dev-xxxxxx-xxxxx       1/1     Running   0          1m

   NAME                            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
   service/flask-app-release-dev   NodePort   10.96.xx.xx    <none>        8080:30080/TCP   1m
   ```

## Accessing the Application

When using Minikube, there are two ways to access the application:

### Method 1: Using Minikube Service (Recommended)
```bash
minikube service flask-app-release-dev -n dev
```
This command will:
- Create a tunnel to the service
- Open the application in your default browser
- Display the URL (usually something like http://127.0.0.1:random_port)

### Method 2: Using Minikube Tunnel
1. Start the tunnel:
   ```bash
   minikube tunnel
   ```
2. Access the application at:
   ```
   http://127.0.0.1:30080
   ```

## Configuration

### Service Configuration (values.yaml)
```yaml
service:
  type: NodePort
  port: 8080
  nodePort: 30080
```

### Environment Variables
- `LOG_LEVEL`: Set logging level (default: INFO)
- `APP_PORT`: Application port (default: 8080)
- `SECRET_KEY`: Secret key for the application
- `DB_PASSWORD`: Database password
- `API_BASE_URL`: Base URL for API
- `MAX_CONNECTIONS`: Maximum number of connections

## Troubleshooting

1. **Cannot access the application**
   - Verify pods are running: `kubectl get pods -n dev`
   - Check service configuration: `kubectl get svc -n dev`
   - Ensure Minikube is running: `minikube status`
   - Try using `minikube service` command for access

2. **Pod not starting**
   - Check pod logs: `kubectl logs -n dev <pod-name>`
   - Describe pod: `kubectl describe pod -n dev <pod-name>`

3. **Service not accessible**
   - Verify NodePort configuration: `kubectl describe svc -n dev flask-app-release-dev`
   - Check Minikube IP: `minikube ip`
   - Use `minikube service` command for proper access

## Cleanup

To remove the deployment:
```bash
# Delete Helm release
helm uninstall flask-app-release-dev -n dev

# Delete namespace (optional)
kubectl delete namespace dev
```

## Additional Commands

### Useful kubectl commands
```bash
# Get pod logs
kubectl logs -n dev <pod-name>

# Describe service
kubectl describe svc -n dev flask-app-release-dev

# Port forward to pod
kubectl port-forward -n dev svc/flask-app-release-dev 8080:8080
```

### Helm commands
```bash
# Upgrade deployment
helm upgrade flask-app-release-dev ./helm-charts -n dev

# List releases
helm list -n dev

# Get release status
helm status flask-app-release-dev -n dev
```

## Security Considerations

1. The application runs as a non-root user in the container
2. Resource limits are set to prevent resource exhaustion
3. Health checks are implemented for better monitoring
4. Logging is configured for debugging and audit purposes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 