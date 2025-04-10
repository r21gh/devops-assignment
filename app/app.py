from flask import Flask, jsonify, request
import os
from prometheus_flask_exporter import PrometheusMetrics
from prometheus_client import Counter, Histogram, Info
import time

app = Flask(__name__)

# Initialize Prometheus metrics
metrics = PrometheusMetrics(app)

# Custom metrics
request_count = Counter('flask_request_count', 'Total number of requests by endpoint', ['endpoint', 'method'])
request_latency = Histogram('flask_request_latency_seconds', 'Request latency in seconds', ['endpoint'])
app_info = Info('flask_app_info', 'Application information')

# Set static information about the app
app_info.info({
    'version': os.getenv('APP_VERSION', 'dev'),
    'environment': os.getenv('ENVIRONMENT', 'development')
})

@app.before_request
def before_request():
    request.start_time = time.time()

@app.after_request
def after_request(response):
    # Record request latency
    if hasattr(request, 'start_time'):
        latency = time.time() - request.start_time
        request_latency.labels(endpoint=request.endpoint).observe(latency)
    
    # Count requests
    request_count.labels(endpoint=request.endpoint, method=request.method).inc()
    
    return response

# Default route
@app.route("/")
def home():
    return "Hello, this is a message from your Python app!"

# New route that uses secrets and configuration from environment variables
@app.route("/config")
def config():
    # Retrieve sensitive and config values from environment variables
    secret_key = os.getenv("SECRET_KEY")
    db_password = os.getenv("DB_PASSWORD")

    # Retrieve non-sensitive config values from environment variables
    api_base_url = os.getenv("API_BASE_URL")
    log_level = os.getenv("LOG_LEVEL")
    max_connections = os.getenv("MAX_CONNECTIONS")
    
    # Return the config information
    return jsonify({
        "message": "Config and secrets accessed",
        "SECRET_KEY": secret_key,
        "DB_PASSWORD": db_password,
        "API_BASE_URL": api_base_url,
        "LOG_LEVEL": log_level,
        "MAX_CONNECTIONS": max_connections
    })

# Health check endpoint
@app.route("/health")
@metrics.do_not_track()
def health():
    return jsonify({"status": "healthy"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
