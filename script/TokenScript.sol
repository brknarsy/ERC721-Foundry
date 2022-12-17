// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../lib/forge-std/src/Script.sol";
import "../src/Token.sol";

contract TokenScript is Script {
    function setUp() public {

    }

    function run() public {
        string memory seedPhrase = vm.readFile(".secret");
        uint256 privateKey = vm.deriveKey(seedPhrase, 0);
        vm.startBroadcast(privateKey);
        Token token = new Token();

        vm.stopBroadcast();
    }
}