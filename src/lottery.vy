# pragma version 0.4.3
"""
@license MIT 
@title A contract to choose a random user to win a lottery
@author Ee Xuan En Arvin
@notice This contract creates a simple lottery system
"""

#-----------------------------------------------------
#                       Imports
#-----------------------------------------------------
from interface import VRFCoordinatorV2plus
import get_random
#-----------------------------------------------------
#                       State
#-----------------------------------------------------

MIN_PARTICIPANT:constant(uint256) = 5 # at least 5 unique addresses 
ENTRY_COST: constant(uint256) = as_wei_value(0.01, "ether") # the entrance fee to participate in wei
VRF_ADDRESS: immutable(VRFCoordinatorV2plus) # the VRF function address

participants: public(HashMap[address, uint256])
initializes: get_random
#-----------------------------------------------------
#                       Functions
#-----------------------------------------------------

@deploy
def __init__(vrf_address: address):
    VRF_ADDRESS = VRFCoordinatorV2plus(vrf_address)

@external
@payable
def enter_raffle ():
    """
    Function to allow a user to enter a raffle, requires payment
    of the entrance fee
    """
    pass

@external
def pick_winner(time: uint256):
    price_call: uint256 = get_random.get_price_per_call(VRF_ADDRESS)
    

@external
def fulfillRandomWords(_requestId: uint256, _randomWords: DynArray[uint256, get_random.MAX_ARRAY_SIZE]):
    """
    Function that gets called when returning random
    from VRF
    """
    
    log get_random.RequestFulfilled(requestId=_requestId, 
    randomWords=_randomWords, payment=get_random.s_requests[_requestId].paid)