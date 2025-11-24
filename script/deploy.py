from src import lottery
from moccasin.boa_tools import VyperContract
from moccasin.config import get_active_network

def deploy() -> VyperContract:
    active_network = get_active_network()
    vrf_address: VyperContract = active_network.manifest_named("vrf_coordinator")
    vrf_wrapper: VyperContract = active_network.manifest_named("vrf_wrapper")
    return lottery.deploy(vrf_address, vrf_wrapper)

def moccasin_main() -> VyperContract:
    return deploy()
