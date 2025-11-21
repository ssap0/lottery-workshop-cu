from src import lottery
from moccasin.boa_tools import VyperContract
from moccasin.config import get_active_network

def deploy(vrf_address: str) -> VyperContract:
    return lottery.deploy(vrf_address)

def moccasin_main() -> VyperContract:
    active_network = get_active_network()
    vrf_address: VyperContract = active_network.manifest_named("vrf_coordinator")
    return deploy(vrf_address)
