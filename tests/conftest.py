import pytest
from script.deploy import deploy

#TEMP sepolia coordinator address


@pytest.fixture(scope="function")
def lottery():
    return deploy()