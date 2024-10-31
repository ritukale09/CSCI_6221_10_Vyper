BOOLEAN_EXAMPLE: constant(bool) = True
bool_ex: public(bool)
integer_example: public(int128)  
@external
def helloWorld():
	self.bool_ex = BOOLEAN_EXAMPLE
	self.integer_example = 1


@external
def transfer(receiver: address, amount: uint256):
    """
    Transfer tokens from the caller 
	to the receiver.
    Includes exception handling to 
	ensure the transfer is valid.
    """
    # Exception Handling: 
	# Check for valid transfer amount
    assert amount > 0, 
	"Transfer amount < 0"

    # Exception Handling: Check for 
	# sufficient balance
    assert self.balances[msg.sender] >= amount, 
	"Insufficient balance"

    # Perform the transfer
    self.balances[msg.sender] -= amount
    self.balances[receiver] += amount

    # Emit the Transfer event
    log Transfer(msg.sender, receiver, amount)


enum Operation:
    ADD
    SUBTRACT

@external
def perform_operation(op: Operation, a: uint256, b: uint256) -> uint256:
    if op == Operation.ADD:
        return a + b
    elif op == Operation.SUBTRACT:
        return a - b
    else:
        assert False, "Invalid operation"


@external
@pure
def add(i:uint256, j:uint256):
    return i+j

