from src import lottery
from moccasin.boa_tools import VyperContract
from os.path import join, dirname
import os
from dotenv import load_dotenv

dotenv_path = join(dirname(__file__), '.env')
load_dotenv(dotenv_path)

VRF_COORDINATOR = os.getenv("VRF_Coordinator")

def deploy() -> VyperContract:
    return lottery.deploy(VRF_COORDINATOR)

def moccasin_main() -> VyperContract:
    return deploy()
