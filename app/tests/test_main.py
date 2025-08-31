import pytest
import sys

# Add the app directory to Python path
sys.path.insert(0, '/home/runner/work/AutoScaleME/AutoScaleME/app')

import main


@pytest.fixture
def client():
    main.app.config['TESTING'] = True
    with main.app.test_client() as client:
        yield client


def test_home(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello from AutoScaleMe!" in response.data


def test_load(client):
    response = client.get('/load')
    assert response.status_code == 200
    json_data = response.get_json()
    assert "prime_count" in json_data
    assert isinstance(json_data["prime_count"], int)
    assert json_data["prime_count"] > 0
