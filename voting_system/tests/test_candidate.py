import pytest
from brownie import Vote, accounts

@pytest.fixture
def vote():
    try:
        return Vote.deploy({'from': accounts[0], 'priority_fee': 10, 'max_fee': 1000000000})
    except Exception as e:
        print(e)

#def test_deploy(get_vote):
#    assert get_vote.tx.status == 1

#tests candidate is created
def test_candidate(vote):
    candidate = vote.create_candidate("John Doe", '0x66aB6D9362d4F35596279692F0251Db635165871', 'Virginia', 30, {'from': accounts[0], 'priority_fee': 10, 'max_fee': 1000000000})
    #print(candidate.events['CandidateCreated'].values())
    #assert candidate.events['CandidateCreated'].values() == ["John Doe", '0x1CEE82EEd89Bd5Be5bf2507a92a755dcF1D8e8dc', 'Virginia', 30]

#def test_ballot(vote):
    # vote.issue(512, 'Serpent', 'Umbra', 'S', '2031-01-02',
    #                  '0x2f44454d59535449462f6e6578742d63657274696669636174652d646170702f', {'from': accounts[0], 'priority_fee': 10, 'max_fee': 1000000000})
    # certificate = vote.Certificates(512)
    # assert certificate['name'] == 'Serpent'
    # assert certificate['course'] == 'Umbra'
    # assert certificate['grade'] == 'S'
    # assert certificate['date'] == '2031-01-02'
    # assert certificate['document'] == '0x2f44454d59535449462f6e6578742d63657274696669636174652d646170702f'
