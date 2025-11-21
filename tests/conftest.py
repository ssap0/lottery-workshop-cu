import pytest
from script.deploy import deploy

#TEMP sepolia coordinator address


@pytest.fixture(scope="session")
def lottery():
    return deploy()