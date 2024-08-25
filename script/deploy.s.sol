// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/MyContract.sol"; // Dosya yolunu doğrulayın

contract DeployScript is Script {
    function run() external {
        uint256 initialNumber = 42; // Başlangıç değeri

        vm.startBroadcast(); // İşlemi başlatın
        MyContract myContract = new MyContract(initialNumber); // IP token ile deploy
        console.log("Contract deployed at:", address(myContract));
        vm.stopBroadcast(); // İşlemi durdurun
    }
}
