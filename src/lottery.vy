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


#-----------------------------------------------------
#                       State
#-----------------------------------------------------

MIN_PARTICIPANT:constant(uint256) = 5 # at least 5 unique addresses 
ENTRY_COST: constant(uint256) = as_wei_value(0.01, "ether")# the entrance fee to participate in wei

participants: public(HashMap[address, uint256])

#-----------------------------------------------------
#                       Functions
#-----------------------------------------------------

@deploy
def __init__():
    pass

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
    pass
    

    

    
