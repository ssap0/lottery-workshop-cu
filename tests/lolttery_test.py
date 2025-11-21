import boa
from eth_utils import to_wei

USERS = [boa.env.generate_address("user") for i in range(10)]
INITIAL_VALUE = to_wei(1, "ether")

def test_enter_lottery(lottery):
    """
    Function to test the entering of a lottery
    """
    idx = 0 # random user to enter 
    boa.env.set_balance(USERS[idx], INITIAL_VALUE)
    with boa.env.prank(USERS[idx]):
        lottery.enter_raffle()

    # check using balance
