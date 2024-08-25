// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    uint256 public number;

    event NumberUpdated(uint256 newNumber);

    constructor(uint256 _initialNumber) {
        number = _initialNumber;
    }

    function setNumber(uint256 _newNumber) public {
        number = _newNumber;
        emit NumberUpdated(_newNumber);
    }

    function getNumber() public view returns (uint256) {
        return number;
    }
}
