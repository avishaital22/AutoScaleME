import pytest
import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from main import app


@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
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
