# CSCI_6221_10_Vyper

Repository for CSCI_6221_10_Vyper group project implementing smart contracts using the Vyper language.

> **IMPORTANT:** DO NOT EDIT OR DELETE FILES IN THE */build and */reports folders. 

## Project Description

This project implements various smart contracts in Vyper, including:
- User information management system
- Voting system
- Example contracts demonstrating Vyper features

## Prerequisites

- Python 3.7+
- [Ganache](https://trufflesuite.com/ganache/)
- [Node.js](https://nodejs.org/)

## Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/CSCI_6221_10_Vyper.git

# Install dependencies
pip install -r requirements.txt

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

# Set up contract instance
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

# Set up contract instance
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
- Ballots: Includes information about the president, vice president, votes, and campaign funds.
- Candidates: Stores candidate details like name, home state, age, and unique candidate ID.
- State Variables: Tracks the next ballot ID and maps ballot and candidate data.

#### Core Functions
- `create_candidate()`: Registers a new candidate with name, address, state, and age.
- `create_ballot()`: Creates a new ballot associating a president and vice president.
- `vote()`: Casts a vote for a specific ballot, optionally with a campaign donation.

#### Security Features 
- Uniqueness checks: Ensures no duplicate ballots or candidates are created.
- Candidate Validation: Validates the existence of candidates and ballots before any actions.
- Event Logging: Provides transparency by logging vote casting, candidate creation, and ballot updates.

### Usage Examples

```
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
```
#### Integration Opportunities
- Identity Verification: Using a separate smart contract to verify voter identity.
- Campaign Management: Facilitating secure and transparent allocation of campaign funds.
- Analytics Dashboards: Utilizing event logs to display real-time election data on a front-end.







