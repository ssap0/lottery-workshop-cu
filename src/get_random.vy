# pragma version 0.4.3
"""
@license MIT 
@title A contract acting as a module to get chainlink random with payment
@author Ee Xuan En Arvin
@notice This contract is a module to support the lottery random from chainlink
"""

from interface import VRFCoordinatorV2plus
from interface import VRFWrapperV2plus

#-----------------------------------------------------
#                       Variables
#-----------------------------------------------------
MAX_ARRAY_SIZE: constant(uint256) = 10
CALLBACK_GAS_LIMIT: constant(uint32) = 25 * (10 ** 5)
NUMWORDS: constant(uint32) = 1
CONRIMATIONS: constant(uint16) = 3
EXTRA_ARGS: constant(Bytes[32]) = b"\x01"

s_requests: HashMap[uint256, RequestStatus]

#-----------------------------------------------------
#                       Declarations
#-----------------------------------------------------
struct RequestStatus:
    paid: uint256 # amount paid in wei
    fulfilled: bool # whether the request has been successfully fulfilled
    randomWords: DynArray[uint256, MAX_ARRAY_SIZE]

#-----------------------------------------------------
#                       Events
#-----------------------------------------------------
event RequestFulfilled:
    requestId: indexed(uint256)
    randomWords: DynArray[uint256, MAX_ARRAY_SIZE]
    payment: uint256


event RandomWordsRequested:
    requestId: uint256
    callbackGasLimit: uint32
    numWords: uint32

@internal
def address(wrapper: VRFWrapperV2plus) -> address:
    return staticcall wrapper.link()


@internal
def requestRandom(vrf: VRFCoordinatorV2plus, wrapper: VRFWrapperV2plus):
    """
    Module mainly uses pay per use instead of subscription
    hence, subscription function will be ignored and 
    not implemented
    """
    price_for_call: uint256 = staticcall wrapper.calculateRequestPriceNative(CALLBACK_GAS_LIMIT, NUMWORDS)
    request_id:uint256 = extcall wrapper.requestRandomWordsInNative(CALLBACK_GAS_LIMIT,
    CONRIMATIONS, NUMWORDS, EXTRA_ARGS, value=price_for_call)

    log RandomWordsRequested(requestId=request_id, callbackGasLimit=CALLBACK_GAS_LIMIT,
    numWords= NUMWORDS)