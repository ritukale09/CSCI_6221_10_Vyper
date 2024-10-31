#ownership.vy
import owner 

initializes: owner

@deploy
def __init__():
    ownable.__init__()

@external
def test_function() -> address:
    return ownable.get_owner() 

@external
def get_times_two(num: int128)->int128:
    return owner.get_times_two(num)
    

