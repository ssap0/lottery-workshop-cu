from src import lottery
from moccasin.boa_tools import VyperContract

def deploy() -> VyperContract:
    return lottery.deploy()

def moccasin_main() -> VyperContract:
    return deploy()
