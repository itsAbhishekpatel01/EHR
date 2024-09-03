// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Registry.sol";

contract PermissionContract {
    // Struct to store permission details
    struct Permission {
        address granter;
        address requester;
        bool isApproved;
    }

    // Mapping to store permissions based on a hash of (granter, requester)
    mapping(bytes32 => Permission) private permissions;

    // Events to be emitted when a permission is requested and approved
    event PermissionRequested(address indexed granter, address indexed requester);
    event PermissionApproved(address indexed granter, address indexed requester);

    // Reference to the Registry
    Registry public registry;

    // Constructor to initialize the registry contract
    constructor(address registryAddress) {
        registry = Registry(registryAddress);
    }

    // Function to request permission
    function requestPermission(uint256 granterPublicKey) external {
        // Check if the requester and granter are registered
        require(registry.checkUser(uint256(uint160(msg.sender))), "Requester is not registered.");
        require(registry.checkUser(granterPublicKey), "Granter is not registered.");

        // Compute the permission key
        bytes32 permissionKey = keccak256(abi.encodePacked(granterPublicKey, msg.sender));
        require(permissions[permissionKey].granter == address(0), "Permission already requested.");

        permissions[permissionKey] = Permission({
            granter: address(uint160(granterPublicKey)),
            requester: msg.sender,
            isApproved: false
        });

        emit PermissionRequested(address(uint160(granterPublicKey)), msg.sender);
    }

    // Function to approve permission
    function approvePermission(uint256 requesterPublicKey) external {
        require(registry.checkUser(uint256(uint160(msg.sender))), "Granter is not registered.");
        bytes32 permissionKey = keccak256(abi.encodePacked(msg.sender, address(uint160(requesterPublicKey))));
        Permission storage permission = permissions[permissionKey];

        require(permission.granter != msg.sender, "Only the granter can approve the request.");
        require(permission.requester != address(uint160(requesterPublicKey)), "Invalid requester.");
        require(!permission.isApproved, "Permission already approved.");

        permission.isApproved = true;


        emit PermissionApproved(msg.sender, address(uint160(requesterPublicKey)));
    }

    // Function to check if a permission is approved
    function isPermissionApproved(uint256 granterPublicKey, uint256 requesterPublicKey) external view returns (bool) {
        bytes32 permissionKey = keccak256(abi.encodePacked(address(uint160(granterPublicKey)),address(uint160(requesterPublicKey))));
        return permissions[permissionKey].isApproved;
    }
}
