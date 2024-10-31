# ownable.vy
owner: address
@deploy
def __init__():
    self.owner = msg.sender

@external
def get_owner() -> address:
    return self.owner

@external
def update_owner(new_owner: address):
    self.owner = new_owner

@external
def multiply_by_two(int128: x) -> int128:
    return x*2

