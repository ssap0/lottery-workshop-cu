import boa
from eth_utils import to_wei
from os.path import join, dirname
import os
from dotenv import load_dotenv

dotenv_path = join(dirname(__file__), '.env')
load_dotenv(dotenv_path)

VRF_COORDINATOR = os.getenv("VRF_Coordinator")


USERS = [boa.env.generate_address("user") for i in range(10)]
INITIAL_VALUE = to_wei(2, "ether")
LOTTERY_COST = to_wei(1, "ether")
idx = 0 # random user to enter 

def test_enter_lottery(lottery):
    """
    Function to test the entering of a lottery
    """
    boa.env.set_balance(USERS[idx], INITIAL_VALUE)
    with boa.env.prank(USERS[idx]):
        lottery.enter_raffle(value=LOTTERY_COST)
        
    # assert logs
    logs = lottery.get_logs()
    log_participant = logs[0].participant

    assert log_participant == USERS[idx]

def test_not_enough_fee(lottery):
    """
    Function to test for entering the lottery without enough value
    """
    boa.env.set_balance(USERS[idx], INITIAL_VALUE)
    with boa.env.prank(USERS[idx]):
        with boa.reverts("Please enter with more fee"):
            lottery.enter_raffle(VALUE=0)

def test_draw_to_fail(lottery):
    """
    Function to test draw without minimun participation
    """
    boa.env.set_balance(USERS[idx], INITIAL_VALUE)
    with boa.env.prank(USERS[idx]):
        lottery.enter_raffle(value=LOTTERY_COST)

    # assert to fail
    with boa.reverts("Not enough participants"):
        lottery.pick_winner()

def test_draw_lottery(lottery):
    for i in range(10):
        idx = i # simple to use for future fuzzing
        boa.env.set_balance(USERS[idx], LOTTERY_COST)
        with boa.env.prank(USERS[idx]):
            lottery.enter_raffle(value=LOTTERY_COST)

    lottery.pick_winner()

    # print results
    #logs = lottery.get_logs()
    #last_log = logs[len(logs) - 1]

    print(f"Winner is {lottery.last_winner()} with money of {boa.env.get_balance(lottery.last_winner())}")
    # print(f"Lottery random cost: {last_log.payment}")

    # assert winner and the value of the contract
    assert boa.env.get_balance(lottery.last_winner()) > 0, "The winner has no money"
    assert boa.env.get_balance(lottery.address) == 0, f"Balance of contract is {boa.env.get_balance(lottery.address)}"
   
