// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Week22Exercise2.sol"; // adjust the path as needed

contract Week22Exercise2Test is Test {
    Week22Exercise2 public challengeContract;


    function setUp() public {
      
        challengeContract = new Week22Exercise2();
    }

    function testChallengeWithRawCalldata() public {

        bytes memory rawCalldata = hex"04989798" // Method ID
            // Parameter offsets:
            hex"0000000000000000000000000000000000000000000000000000000000000040"
            hex"0000000000000000000000000000000000000000000000000000000000000080"
            // String length (14 bytes)
            hex"000000000000000000000000000000000000000000000000000000000000000e"
            // String "attack at dawn" padded:
            hex"61747461636b206174206461776e000000000000000000000000000000000000"
            // Signature length (65 bytes)
            hex"0000000000000000000000000000000000000000000000000000000000000041"
            // Signature r (32 bytes):
            hex"e5d0b13209c030a26b72ddb84866ae7b32f806d64f28136cb5516ab6ca15d3c4"
            // Signature s (32 bytes):
            hex"38d9e7c79efa063198fda1a5b48e878a954d79372ed71922003f847029bf2e75"
            // Signature v (1 byte, padded):
            hex"1b00000000000000000000000000000000000000000000000000000000000000";

    
        (bool success, ) = address(challengeContract).call(rawCalldata);
        require(success, "Challenge call failed");

        bytes memory signature = hex"e5d0b13209c030a26b72ddb84866ae7b32f806d64f28136cb5516ab6ca15d3c4"
            hex"38d9e7c79efa063198fda1a5b48e878a954d79372ed71922003f847029bf2e75"
            hex"1b";

       
        bool isUsed = challengeContract.used(signature);
        assertTrue(isUsed, "Signature should be marked as used");
    }
}
