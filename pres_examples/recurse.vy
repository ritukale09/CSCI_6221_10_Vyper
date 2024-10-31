@pure
def factorial(n: uint256) -> uint256:
    if n == 0:
        return 1
    else:
        return n * self.factorial(n - 1)