import pytest
from brownie import SocialBenefits, accounts, reverts

@pytest.fixture
def benefits():
    return SocialBenefits.deploy({'from': accounts[0]})

def test_register_beneficiary(benefits):
    benefits.register_beneficiary(accounts[1], {'from': accounts[0]})
    assert benefits.beneficiaries(accounts[1])[1] == True  # checks eligible status

def test_claim_benefit(benefits):
    # Fund the treasury first
    benefits.fund_treasury({'from': accounts[0], 'value': '2 ether'})
    
    # Register beneficiary
    benefits.register_beneficiary(accounts[1], {'from': accounts[0]})
    
    # Claim Medicare benefit
    initial_balance = accounts[1].balance()
    benefits.claim_benefit("MEDICARE", {'from': accounts[1]})
    
    # Verify balance increased
    assert accounts[1].balance() > initial_balance

def test_unauthorized_registration(benefits):
    with reverts("Only owner can register beneficiaries"):
        benefits.register_beneficiary(accounts[2], {'from': accounts[1]})
