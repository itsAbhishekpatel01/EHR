// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract dataContract {

    struct DataRecord {
        address dataOwner;         
        string dataType;           
    }

    mapping(address => DataRecord[]) private dataRecords;

  
    event DataAdded(address indexed user, string dataType);
    event UserNotified(address indexed user);


    modifier onlyDataOwner(address _dataOwner) {
        require(msg.sender == _dataOwner, "Caller is not the data owner");
        _;
    }

    
    function addEHRData(address _dataOwner) public {
        DataRecord memory newRecord = DataRecord({
            dataOwner: _dataOwner,
            dataType: _dataType,
        });
        dataRecords[_dataOwner].push(newRecord);
        emit DataAdded(_dataOwner, _dataType);
        notifyUser(_dataOwner);
    }



    function notifyUser(address _user) internal {
        emit UserNotified(_user);
    }

    function searchData(address _dataOwner, string memory _dataType) public view returns (DataRecord[] memory) {
        uint256 count = 0;

        
        for (uint256 i = 0; i < dataRecords[_dataOwner].length; i++) {
            if (keccak256(bytes(dataRecords[_dataOwner][i].dataType)) == keccak256(bytes(_dataType))) {
                count++;
            }
        }

        
        DataRecord[] memory results = new DataRecord[](count);
        uint256 index = 0;

        for (uint256 i = 0; i < dataRecords[_dataOwner].length; i++) {
            if (keccak256(bytes(dataRecords[_dataOwner][i].dataType)) == keccak256(bytes(_dataType))) {
                results[index] = dataRecords[_dataOwner][i];
                index++;
            }
        }

        return results;
    }
}
