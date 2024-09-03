// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Registry {
    // State variables
    address public creator;
    uint8 public totalUsers;
    mapping(uint256 => string) public user;
    uint256[] private registered; 
    string[4] public roles;
    
    // Event to signal successful registration
    event UserRegistered(uint256 publicKey, string role);
    // modifier

    constructor() {
        creator = msg.sender;
        totalUsers = 0;
        roles[0] = "patient";
        roles[1] = "care provider";
        roles[2] = "researcher";
        roles[3] = "regulator";
    }

    // Function to check if a user is registered
    function checkUser(uint256 publicKey) public view returns (bool) {
        for (uint256 i = 0; i < registered.length; i++) {
            if (publicKey == registered[i]) {
                return true;
            }
        }
        return false;
    }

    // Function to register a user
    function registerUser(uint256 publicKey, string memory role) public {
        require(!checkUser(publicKey), "User already registered!");
        
        bool validRole = false;
        for (uint256 i = 0; i < roles.length; i++) {
            if (keccak256(abi.encodePacked(role)) == keccak256(abi.encodePacked(roles[i]))) {
                validRole = true;
                break;
            }
        }
        require(validRole, "Invalid role!");

        user[publicKey] = role;
        registered.push(publicKey); // Add user 
        totalUsers++;
        
        emit UserRegistered(publicKey, role); // Emit event with parameters
    }
}
