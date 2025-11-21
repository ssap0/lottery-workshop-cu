import pytest
from script.deploy import deploy
from script.deploy_mock import deploy_mock

@pytest.fixture(scope="session")
def mock_vrf():
    return deploy_mock()

@pytest.fixture(scope="function")
def lottery(mock_vrf):
    return deploy(mock_vrf)

