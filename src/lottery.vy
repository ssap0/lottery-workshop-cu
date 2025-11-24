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
from interface import VRFWrapperV2plus
import get_random
#-----------------------------------------------------
#                       State
#-----------------------------------------------------

MIN_PARTICIPANT:constant(uint256) = 5 # at least 5 unique addresses
MAX_PARTICIPANT:constant(uint256) = 10 # at least 5 unique addresses 
ENTRY_COST: constant(uint256) = as_wei_value(1, "ether") # the entrance fee to participate in wei
VRF_Coordinator: immutable(VRFCoordinatorV2plus) # the VRF function address
VRF_Wrapper: immutable(VRFWrapperV2plus) # VRF Wrapper

participants: public(DynArray[address, MAX_PARTICIPANT])
last_winner: public(address)
is_drawing: bool
initializes: get_random

#-----------------------------------------------------
#                       Events
#-----------------------------------------------------
event LotteryEntered:
    participant: address
    prize_pool: uint256

event LotteryEnded:
    winner: address
    prize_pool: uint256
    
#-----------------------------------------------------
#                       Functions
#-----------------------------------------------------

@deploy
def __init__(vrf_address: address, wrapper_address: address):
    VRF_Coordinator = VRFCoordinatorV2plus(vrf_address)
    VRF_Wrapper = VRFWrapperV2plus(wrapper_address)
    self.is_drawing = False

@external
@payable
def enter_raffle ():
    """
    Function to allow a user to enter a raffle, requires payment
    of the entrance fee, multiple participation is allowed
    """
    assert msg.value >= ENTRY_COST, "Please enter with more fee"
    assert self.is_drawing == False, "Lottery Drawing in process"
    self.participants.append(msg.sender)
    log LotteryEntered(participant=msg.sender, prize_pool=self.balance)

@external
def pick_winner():
    assert(len(self.participants) >= MIN_PARTICIPANT), "Not enough participants"
    # pick a winner, get fund from pariticipants
    get_random.requestRandom(VRF_Coordinator, VRF_Wrapper)
    self.is_drawing = True
    

@external
def fulfillRandomWords(_requestId: uint256, _randomWords: DynArray[uint256, get_random.MAX_ARRAY_SIZE]):
    """
    Function that gets called when returning random
    from VRF
    """
    assert (msg.sender == get_random.address(VRF_Wrapper)
    ), "Only coordinator can fulfill!"

    # select and send to winner
    index_of_winner: uint256 = _randomWords[0] % len(self.participants)

    log LotteryEnded(winner=self.participants[index_of_winner], prize_pool=self.balance)
    raw_call(self.participants[index_of_winner], b"", value = self.balance)
    self.last_winner = self.participants[index_of_winner]
    # reset array
    self.participants = []
    self.is_drawing = False
    # log
    log get_random.RequestFulfilled(requestId=_requestId, 
    randomWords=_randomWords, payment=get_random.s_requests[_requestId].paid)
