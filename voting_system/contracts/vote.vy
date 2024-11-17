#vote.vy
#@version 0.4.0

# struct to store a ballot offering
struct ballot:
    president: address
    ballot_id: int128
    vice_president: address
    votes: uint256
    campaign_fund: uint256

# struct to store candidate's info 
struct candidate:
    name: String[100]
    candidate_id: address
    home_state: String[100]
    age: uint256

# state vars
candidates: public(HashMap[address, candidate])
ballots: public(HashMap[int128, ballot])
next_ballot_id: int128
vote_count: int128
voters: public(HashMap[address, bool])

# event for when a vote happens to be caught by frontend
event VoteCast:
    candidate: address
    voter: address
    donation: uint256

# event for when Candidates are created to be caught by frontend
event CandidateCreated:
    candidate_name: String[100]
    candidate_address: address
    candidate_state: String[100]
    candidate_age: uint256

# event for when Ballots are created to be caught by frontend
event BallotCreated:
    pres: address
    vice: address
    ballot_id: int128
    votes: uint256

# event for when Ballots are updated to be caught by frontend
event BallotUpdated:
    pres: address
    vice: address
    ballot_id: int128
    votes: uint256

# event for when a winner is chosen to be caught by frontend
event WinnerChosen:
    pres: address
    vice: address
    ballot_id: int128
    votes: uint256

@deploy
def __init__():
    """
    Constructor to initialize ballots
    """
    self.next_ballot_id = 0
    self.vote_count = 0

@internal
def _ballot_created(main_pres: address, vp: address, ballot_id: int128, votes: uint256):
    """
    @dev Internal shared logic for logging a ballot creation event
    """
    log BallotCreated(main_pres, vp, ballot_id, votes)

@internal
def _ballot_updated(main_pres: address, vp: address, ballot_id: int128, votes: uint256):
    """
    @dev Internal shared logic for logging a ballot update event
    """
    log BallotUpdated(main_pres, vp, ballot_id, votes)

@external
def create_ballot(main_pres: address, vice_pres: address):
    #create a ballot and add it to ballots hashmap
    assert self.next_ballot_id != 10, "Cannot create more than 10 ballots"
 
    pres_inst: candidate = self.candidates[main_pres]
    vice_inst: candidate = self.candidates[vice_pres]

    #check to ensure candidates have been created
    assert pres_inst.candidate_id == main_pres and vice_inst.candidate_id == vice_pres, "President or Vice President does not exist"

    #check to make sure that ballot for these candidates doesn't already exist
    for ind: int128 in range(0,10):
        if(ind<self.next_ballot_id):
            assert self.ballots[ind].president != main_pres or self.ballots[ind].vice_president != vice_pres, "A Ballot for these candidates already exists"
        else:
            break

    ballot_instance: ballot = ballot({president: main_pres, ballot_id: self.next_ballot_id, vice_president: vice_pres, votes: 0, campaign_fund: 0})
    self.ballots[self.next_ballot_id] = ballot_instance
    self._ballot_created(ballot_instance.president, ballot_instance.vice_president, self.next_ballot_id, ballot_instance.votes)
    self.next_ballot_id+=1

@internal
def _candidate_created(name: String[100], _ad: address, state: String[100], age: uint256):
    """
    @dev Internal shared logic for logging a candidate creation event
    """
    log CandidateCreated(name, _ad, state, age)

@external
def create_candidate(candidate_name: String[100], candidate_address: address,candidate_state: String[100], candidate_age: uint256):
    #create a candidate struct and add it to candidates hashmap
    #check president and vice president are old enough
    assert candidate_age >= 35, "This person is not old enough to run for office"
    candidate_instance: candidate = candidate({name: candidate_name, candidate_id: candidate_address, home_state:candidate_state, age: candidate_age})
    self.candidates[candidate_instance.candidate_id] = candidate_instance
    self._candidate_created(candidate_instance.name, candidate_instance.candidate_id, candidate_instance.home_state, candidate_instance.age)

@internal
def _vote_cast(_by: address, _to: address, _value: uint256):
    """
    @dev Internal shared logic for logging a vote event
    """
    log VoteCast(_by, _to, _value)

@external
@payable
def vote(ballot_identifier: int128):
    """
    Function to vote for a ballot
    """
    assert ballot_identifier < self.next_ballot_id and self.next_ballot_id != 0, "no ballot for ballot id"
    assert self.voters[msg.sender] != True, "Cannot vote twice"

    if(msg.value > 0): #someone sent money along with their vote
        self.ballots[ballot_identifier].campaign_fund += msg.value #add to campaign fund
        send(self.ballots[ballot_identifier].president, msg.value) #sending money during voting goes to president's address
        

    # add vote to ballot
    self.ballots[ballot_identifier].votes += 1

    # log the Vote event and ballot update to the frontend
    self._vote_cast(msg.sender, self.ballots[ballot_identifier].president, msg.value)
    self.voters[msg.sender] = True
    self._ballot_updated(self.ballots[ballot_identifier].president, self.ballots[ballot_identifier].vice_president, ballot_identifier, self.ballots[ballot_identifier].votes)
    self.vote_count+=1

@internal
def _winner_chosen(main_pres: address, vp: address, ballot_id: int128, votes: uint256):
    """
    @dev Internal shared logic for logging that a winner has been chosen
    """
    log WinnerChosen(main_pres, vp, ballot_id, votes)

@external
def get_winning_ballot()->int128:
    #reads ballot vote count and returns ballot id of winner
    maxvotes: uint256 = 0
    winning_ballot: int128 = -1

    for ind: int128 in range(0,10):
        if(ind<self.next_ballot_id):
            if(self.ballots[ind].votes>=maxvotes):
                winning_ballot = ind
                maxvotes = self.ballots[ind].votes
        else:
            break

    assert maxvotes != 0 and winning_ballot != -1, "No Winner Selected"
    self._winner_chosen(self.ballots[winning_ballot].president, self.ballots[winning_ballot].vice_president, winning_ballot, self.ballots[winning_ballot].votes)
    return winning_ballot