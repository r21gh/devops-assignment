from flask import Flask, jsonify, request, make_response, render_template_string
import os
import logging
from logging.handlers import RotatingFileHandler
import time

# Get log level from environment variable
log_level_name = os.getenv("LOG_LEVEL", "INFO").upper()
log_level = getattr(logging, log_level_name, logging.INFO)

# Configure logging
logging.basicConfig(
    level=log_level,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[logging.StreamHandler()]
)
logger = logging.getLogger(__name__)
logger.info(f'Logger initialized with level: {log_level_name}')

app = Flask(__name__)

# HTML template for the home page
HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Flask App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .message {
            color: #666;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Flask App</h1>
        <div class="message">
            {{ message }}
        </div>
    </div>
</body>
</html>
"""

# Request logging middleware
@app.before_request
def log_request_info():
    logger.debug('Request Headers: %s', dict(request.headers))
    logger.info('Request Method: %s, Path: %s', request.method, request.path)
    if request.data:
        logger.debug('Request Body: %s', request.get_data().decode())

@app.after_request
def log_response_info(response):
    logger.info('Response Status: %s', response.status)
    logger.debug('Response Headers: %s', dict(response.headers))
    return response

# Default route
@app.route("/")
def home():
    logger.info('Processing home route request')
    message = "Hello, this is a message from your Python app!"
    return render_template_string(HTML_TEMPLATE, message=message)

# New route that uses secrets and configuration from environment variables
@app.route("/config")
def config():
    logger.info('Processing config route request')
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
def health():
    logger.info('Processing health check request')
    return jsonify({"status": "healthy"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("APP_PORT", 8080)))
