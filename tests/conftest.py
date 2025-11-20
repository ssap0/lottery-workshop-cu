import pytest
from script.deploy import deploy

#TEMP sepolia coordinator address
VRF_COORDINATOR = "0x9DdfaCa8183c41ad55329BdeeD9F6A8d53168B1B"

@pytest.fixture(scope="session")
def lottery():
    return deploy()