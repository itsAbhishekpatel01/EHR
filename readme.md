# EHR - Electronic Health Record System

## Overview

The **EHR (Electronic Health Record)** system is a blockchain-based application designed to manage user registrations and permissions securely and transparently. Leveraging Ethereum smart contracts, the system provides a decentralized solution for handling user data and permissions.

## Tech Stack

- **Blockchain Platform:** Ethereum
- **Programming Language:** Solidity
- **Smart Contract Version:** ^0.8.0
- **Development Environment:** Remix IDE or Truffle Suite (for testing and deployment)
- **Deployment:** Ethereum Mainnet or test networks like Rinkeby or Ropsten

## Components

### 1. Registry Contract

**File:** `Registry.sol`

**Purpose:** Manages user registrations and roles.

**Key Features:**
- **State Variables:**
  - `creator`: Address of the contract creator.
  - `totalUsers`: Number of registered users.
  - `user`: Mapping from public key to user role.
  - `registered`: Array storing registered public keys.
  - `roles`: Array of predefined user roles.

- **Events:**
  - `UserRegistered`: Emitted when a new user is registered.

- **Functions:**
  - `checkUser(uint256 publicKey)`: Checks if a user is registered.
  - `registerUser(uint256 publicKey, string memory role)`: Registers a new user with a specified role.

### 2. Permission Contract

**File:** `PermissionContract.sol`

**Purpose:** Manages permission requests and approvals between registered users.

**Key Features:**
- **Struct:**
  - `Permission`: Stores details about permissions, including the granter, requester, and approval status.

- **Events:**
  - `PermissionRequested`: Emitted when a permission request is made.
  - `PermissionApproved`: Emitted when a permission request is approved.

- **Functions:**
  - `requestPermission(uint256 granterPublicKey)`: Allows a user to request permission from another user non-incentive based.
  - `approvePermission(uint256 requesterPublicKey)`: Allows a user to approve a permission request non-incentive based.
  - `isPermissionApproved(uint256 granterPublicKey, uint256 requesterPublicKey)`: Checks if a permission has been approved.

**Dependencies:**
- **Registry Contract:** This contract depends on the `Registry` contract for verifying user registration and handling user roles.

## Installation & Setup

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/alucard017/EHR.git
   cd EHR
