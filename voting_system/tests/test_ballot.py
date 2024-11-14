import pytest
from brownie import Vote, accounts

@pytest.fixture
def vote():
    try:
        return Vote.deploy({'from': accounts[0], 'priority_fee': 10, 'max_fee': 1000000000})
    except Exception as e:
        print(e)

#tests candidate is created
def test_candidate(vote):
    candidate = vote.create_candidate("John Doe", '0x66aB6D9362d4F35596279692F0251Db635165871', 'Virginia', 30, {'from': accounts[0], 'priority_fee': 10, 'max_fee': 1000000000})
    assert candidate.events['CandidateCreated'].values() == ["John Doe", '0x1CEE82EEd89Bd5Be5bf2507a92a755dcF1D8e8dc', 'Virginia', 30]

#test vp candidate
def test_vp_candidate(vote):
    candidate = vote.create_candidate("Jane Smith", '0x66aB6D9362d4F35596279692F0251Db635165871', 'Texas', 35, {'from': accounts[0], 'priority_fee': 10, 'max_fee': 1000000000})
    assert candidate.events['CandidateCreated'].values() == ["John Doe", '0x1CEE82EEd89Bd5Be5bf2507a92a755dcF1D8e8dc', 'Virginia', 30]