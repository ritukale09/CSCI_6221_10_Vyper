from vyper.interfaces import ERC20

struct BenefitType:
    name: String[32]
    monthly_amount: uint256
    is_active: bool
    last_claimed: uint256

struct Beneficiary:
    address: address
    eligible: bool
    benefit_types: DynArray[BenefitType, 10]
    total_received: uint256

# Events
event BenefitClaimed:
    beneficiary: indexed(address)
    benefit_type: String[32]
    amount: uint256
    timestamp: uint256

event BeneficiaryRegistered:
    beneficiary: indexed(address)
    timestamp: uint256

# State Variables
beneficiaries: public(HashMap[address, Beneficiary])
benefit_types: public(HashMap[String[32], uint256])  # name -> amount
owner: public(address)
treasury: public(address)

@external
def __init__():
    """
    Initialize contract with default benefit types and amounts
    """
    self.owner = msg.sender
    self.treasury = msg.sender
    
    # Set default benefit amounts (in Wei)
    self.benefit_types["MEDICARE"] = 500_000_000_000_000_000  # 0.5 ETH
    self.benefit_types["MEDICAID"] = 300_000_000_000_000_000  # 0.3 ETH
    self.benefit_types["SOCIAL_SECURITY"] = 400_000_000_000_000_000  # 0.4 ETH

@external
def register_beneficiary(beneficiary: address):
    """
    Register a new beneficiary for benefits
    """
    assert msg.sender == self.owner, "Only owner can register beneficiaries"
    assert not self.beneficiaries[beneficiary].eligible, "Already registered"
    
    self.beneficiaries[beneficiary] = Beneficiary({
        address: beneficiary,
        eligible: True,
        benefit_types: [],
        total_received: 0
    })
    
    log BeneficiaryRegistered(beneficiary, block.timestamp)

@external
def claim_benefit(benefit_type: String[32]):
    """
    Claim a specific benefit type
    """
    assert self.beneficiaries[msg.sender].eligible, "Not eligible for benefits"
    assert self.benefit_types[benefit_type] > 0, "Invalid benefit type"
    
    # Check if contract has enough balance
    amount: uint256 = self.benefit_types[benefit_type]
    assert self.balance >= amount, "Insufficient contract balance"
    
    # Transfer benefit amount
    send(msg.sender, amount)
    
    # Update beneficiary records
    self.beneficiaries[msg.sender].total_received += amount
    
    log BenefitClaimed(msg.sender, benefit_type, amount, block.timestamp)

@external
@payable
def fund_treasury():
    """
    Allow funding the treasury for benefit payments
    """
    assert msg.value > 0, "Must send ETH"

@external
def update_benefit_amount(benefit_type: String[32], new_amount: uint256):
    """
    Update the amount for a specific benefit type
    """
    assert msg.sender == self.owner, "Only owner can update benefits"
    self.benefit_types[benefit_type] = new_amount

@view
@external
def get_beneficiary_total(beneficiary: address) -> uint256:
    """
    Get total benefits received by a beneficiary
    """
    return self.beneficiaries[beneficiary].total_received
