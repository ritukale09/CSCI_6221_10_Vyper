#an address maps to an unsigned int
balances: public(HashMap[address, uint256])
arr: int128[3]
z: decimal

@external
def set_balance(addr: address, val: uint256):
    self.balances[addr] = val
    self.arr = [1,2,3]
    self.arr[0] = 10
    self.z = convert(5, decimal) + 5.5 