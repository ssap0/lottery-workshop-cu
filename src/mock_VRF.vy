# pragma version 0.4.3
"""
@license MIT 
@title A contract to mock a chainlink VRF 
@author Ee Xuan En Arvin
@notice Mock chainlink vrf with needed function
"""

from interface import VRFWrapperV2plus

implements: VRFWrapperV2plus

#-----------------------------------------------------
#                       State
#-----------------------------------------------------

MAX_ARRAY_SIZE: constant(uint256) = 10
PRICE: constant(uint256) = 100 # random cost 
last_id: uint256

#-----------------------------------------------------
#                       Functions
#-----------------------------------------------------

@deploy
def __init__():
    self.last_id = 0

@external
@view
def lastRequestId() -> uint256:
    return self.last_id

@external
@view
def calculateRequestPrice(_callbackGasLimit: uint32, _numWords:uint32) -> uint256:
    return PRICE

@external
@view
def calculateRequestPriceNative(_callbackGasLimit: uint32, _numWords:uint32) -> uint256:
    return PRICE

@external
@payable
def requestRandomWordsInNative(
    _callbackGasLimit: uint32 ,
    _requestConfirmations: uint16 ,
    _numWords: uint32 ,
   extraArgs: Bytes[1024]
  )  -> uint256:

  self.last_id += 1

  # call the function
  words: DynArray[uint256, MAX_ARRAY_SIZE] = [77]
  call_data: Bytes[3236] = abi_encode(
        self.last_id,
        words,
        method_id=method_id("fulfillRandomWords(uint256,uint256[])"),
    )

  response: Bytes[32] = raw_call(msg.sender, call_data, max_outsize=32)
  return self.last_id

@external
@view
def link()-> address:
    return self

@external
@view
def linkNativeFeed() -> address:
    return self