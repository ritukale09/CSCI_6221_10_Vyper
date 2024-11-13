# user_info.vy

struct UserInfo:
    license_number: String[20]
    license_expiration: uint256  # timestamp
    voter_registered: bool
    exists: bool

# Mapping from user address to their information
users: public(HashMap[address, UserInfo])

@external
def register_user(license_num: String[20], expiration: uint256):
    """
    Register a new user with their driver's license information
    """
    assert not self.users[msg.sender].exists, "User already registered"
    
    self.users[msg.sender] = UserInfo({
        license_number: license_num,
        license_expiration: expiration,
        voter_registered: False,
        exists: True
    })

@external
def update_license(license_num: String[20], expiration: uint256):
    """
    Update user's license information
    """
    assert self.users[msg.sender].exists, "User not registered"
    
    self.users[msg.sender].license_number = license_num
    self.users[msg.sender].license_expiration = expiration

@external
def update_voter_status(is_registered: bool):
    """
    Update voter registration status
    """
    assert self.users[msg.sender].exists, "User not registered"
    
    self.users[msg.sender].voter_registered = is_registered

@view
@external
def get_user_info() -> UserInfo:
    """
    Get the current user's information
    """
    assert self.users[msg.sender].exists, "User not registered"
    return self.users[msg.sender]