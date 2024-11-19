# CSCI_6221_10_Vyper

Repository for CSCI_6221_10_Vyper group project implementing smart contracts using the Vyper language.

> **IMPORTANT:** DO NOT EDIT OR DELETE FILES IN THE */build and */reports folders. These are used by Brownie.

## Project Description

This project implements various smart contracts in Vyper, including:
- User information management system
- Voting system
- Example contracts demonstrating Vyper features

## Prerequisites

- Python 3.7+
- [Brownie](https://eth-brownie.readthedocs.io/)
- [Ganache](https://trufflesuite.com/ganache/)
- [Node.js](https://nodejs.org/)

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/CSCI_6221_10_Vyper.git

# Install dependencies
pip install -r requirements.txt

# Install Brownie
pip install eth-brownie
```

## user_info.vy 

This Vyper smart contract implements a decentralized system for managing personal identification information.

### Features

#### Data Storage
- Driver's license number (String)
- License expiration date (Timestamp)
- Voter registration status (Boolean)

#### Core Functions
- `register_user()`: Creates new user profile
- `update_license()`: Updates license information
- `update_voter_status()`: Updates voter registration
- `get_user_info()`: Retrieves user data

#### Security Features
- Address-based user identification 
- Existence checks before updates
- Public view functions for transparency

### Usage Examples

```python
# Deploy contract
brownie run scripts/deploy_user_info.py

# In Brownie console
>>> user_info = UserInfo.at('CONTRACT_ADDRESS')

# Register new user
>>> user_info.register_user("DL123456", 1735689600)  # License number, expiration timestamp

# Update license information
>>> user_info.update_license("DL789012", 1767225600)

# Update voter registration
>>> user_info.update_voter_status(True)

# View user information
>>> user_info.get_user_info()

```

### social_benefits.vy

This Vyper smart contract implements a decentralized system for managing and distributing social benefits like Medicare, Medicaid, and Social Security.

### Features

#### Benefit Types
- Medicare (0.5 ETH monthly)
- Medicaid (0.3 ETH monthly)
- Social Security (0.4 ETH monthly)

#### Data Storage
- Beneficiary information
- Benefit claim history
- Treasury management
- Benefit type configurations

#### Core Functions
- `register_beneficiary()`: Registers new benefit recipients
- `claim_benefit()`: Processes benefit claims
- `fund_treasury()`: Adds funds to treasury
- `update_benefit_amount()`: Modifies benefit amounts
- `get_beneficiary_total()`: Views total benefits received

#### Security Features
- Owner-controlled registration
- Treasury balance checks
- Eligibility verification
- Event logging for transparency

### Usage Examples

```python
# Deploy contract
brownie run scripts/deploy_social_benefits.py

# In Brownie console
>>> benefits = SocialBenefits.at('CONTRACT_ADDRESS')

# Fund treasury
>>> benefits.fund_treasury({'value': "10 ether"})

# Register new beneficiary
>>> benefits.register_beneficiary('BENEFICIARY_ADDRESS')

# Claim benefit
>>> benefits.claim_benefit("MEDICARE")

# Check total benefits received
>>> benefits.get_beneficiary_total('BENEFICIARY_ADDRESS')
```

#### Integration with User Info System
The social benefits system can be used alongside the user information system to:
- Verify identity
- Validate eligibility
- Track benefit distributions
- Maintain compliance records

## vote.vy

This Vyper smart contract implements a decentralized voting system for managing elections and campaigns.

### Features

#### Data Storage
- Ballots: Information about each ballot, including president, vice president, votes, and campaign funds.
- Candidates: Stores candidate details like name, unique ID (address), home state, and age.
- State Variables: Maintains the next ballot ID and mappings for ballots and candidates.

#### Core Functions
- create_candidate(): Registers a new candidate by storing their details.
- create_ballot(): Creates a ballot associating a president and vice president.
- vote(): Allows users to cast votes for a ballot and optionally donate funds to the campaign.

#### Security Features
- Candidate Validation: Ensures that candidates exist before creating a ballot.
- Duplicate Checks: Prevents duplicate ballots for the same president and vice president pair.
- Event Logging: Transparently logs candidate creation, ballot updates, and vote casting.

### User Examples

# Register a new candidate  
>>> voting.create_candidate("Alice Johnson", 'CANDIDATE_ADDRESS', "Texas", 50)

# Create a new ballot  
>>> voting.create_ballot('PRESIDENT_ADDRESS', 'VICE_PRESIDENT_ADDRESS')

# Cast a vote  
>>> voting.vote(0, 1000000000000000000)  # Vote for ballot ID 0 and donate 1 ETH (in Wei)

# Retrieve candidate details  
>>> voting.candidates('CANDIDATE_ADDRESS')  

# Retrieve ballot details  
>>> voting.ballots(0)

#### Integration Opportunities

The voting system can integrate with external systems for:
- Identity Verification: Using a separate smart contract to verify voter identity.
- Campaign Management: Facilitating secure and transparent allocation of campaign funds.
- Analytics Dashboards: Utilizing event logs to display real-time election data on a frontend.

