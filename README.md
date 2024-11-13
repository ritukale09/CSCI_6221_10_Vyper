# CSCI_6221_10_Vyper

Repository for CSCI_6221_10_Vyper group project implementing smart contracts using the Vyper language.

> **IMPORTANT:** DO NOT EDIT OR DELETE FILES IN THE voting_system/build and voting_system/reports folders. These are used by Brownie.

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
