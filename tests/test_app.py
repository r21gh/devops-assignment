import pytest
from app.app import app
import os

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_route(client):
    """Test the home route returns the expected message"""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, this is a message from your Python app!" in response.data

def test_config_route_with_env_vars(client):
    """Test the config route with environment variables set"""
    # Set test environment variables
    test_vars = {
        "SECRET_KEY": "test_secret",
        "DB_PASSWORD": "test_password",
        "API_BASE_URL": "http://test-api.com",
        "LOG_LEVEL": "DEBUG",
        "MAX_CONNECTIONS": "100"
    }
    
    for key, value in test_vars.items():
        os.environ[key] = value

    response = client.get('/config')
    assert response.status_code == 200
    
    json_data = response.get_json()
    assert json_data["message"] == "Config and secrets accessed"
    
    # Check if all environment variables are present in response
    for key, value in test_vars.items():
        assert json_data[key] == value

def test_config_route_without_env_vars(client):
    """Test the config route when environment variables are not set"""
    # Clear test environment variables
    test_vars = ["SECRET_KEY", "DB_PASSWORD", "API_BASE_URL", "LOG_LEVEL", "MAX_CONNECTIONS"]
    for key in test_vars:
        if key in os.environ:
            del os.environ[key]

    response = client.get('/config')
    assert response.status_code == 200
    
    json_data = response.get_json()
    assert json_data["message"] == "Config and secrets accessed"
    
    # Check if all environment variables are None when not set
    for key in test_vars:
        assert json_data[key] is None 