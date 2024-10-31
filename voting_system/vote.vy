#vote.vy
#pragma optimize gas

from ethereum.ercs import IERC20

# struct to store a ballot offering
struct ballot:
    president: candidate
    ballot_id: uint256
    vice_president: candidate
    votes: uint256
    campaign_fund: uint256

# struct to store candidate's info 
struct candidate:
    name: String[100]
    candidate_id: address
    home_state: String[100]
    age: uint256

# state vars
ballots: public(HashMap[uint256, ballot])
next_ballot_id: uint256

# event for when a vote happens to be caught by frontend
#event VoteCast:
#    candidate: address
#    voter: address
#    amount: uint256

@deploy
def __init__():
    """
    Constructor to initialize ballots
    """
    self.next_ballot_id = 0

@external
def add_ballot():
    pass 

@external
@payable
def vote(ballot_identifier: uint256):
    """
    Function to vote for a ballot
    """
    assert ballot_identifier < self.next_ballot_id and self.next_ballot_id != 0, "no ballot for ballot id"

    if(msg.value > 0): #someone sent money along with their vote
        self.ballots[ballot_identifier].campaign_fund += msg.value #add to campaign fund
        send(self.ballots[ballot_identifier].president.candidate_id, msg.value) #sending money during voting goes to president's address
    

    # add vote to ballot
    self.ballots[ballot_identifier].votes += 1

    # log the Vote event to the frontend
    #log VoteCast(candidate, msg.sender, msg.value)

@external
@view
def get_all_ballots():
    for ballot_info: uint256 in range(0, self.next_ballot_id, bound=100):
        self.get_ballot_info(ballot_info)

@view
@internal
def get_ballot_info(ballot_identifier: uint256) -> (uint256, uint256):
    """
    Returns the ballots total votes and total funds received for their campaign
    """
    assert ballot_identifier < self.next_ballot_id and self.next_ballot_id != 0, "no ballot for ballot id"
    return (self.ballots[ballot_identifier].votes, self.ballots[ballot_identifier].campaign_fund)
