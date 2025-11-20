import pytest
from script.deploy import deploy

@pytest.fixture(scope="session")
def lottery():
    return deploy()