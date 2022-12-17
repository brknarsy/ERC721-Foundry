// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../lib/forge-std/src/Test.sol";
import "../src/Token.sol";

contract TokenTest is Test {
    Token token;

    function setUp() public {
        token = new Token();
    }

    function testTokenAttributes() public {
        assertEq(token.name(), "Token");
    }

    function testMinting() public {
        token.safeMint(msg.sender);
        assertEq(token.ownerOf(0), msg.sender);
        assertEq(token.tokenURI(0), "https://brknarsy.github.io/erc721-foundry/jsons/1.json");
    }

    function testMintingFromAnotherAddress() public {
        address minter = address(0x2);
        vm.startPrank(minter);
        vm.expectRevert("Ownable: caller is not the owner");
        token.safeMint(minter);
        vm.stopPrank();
    }

    function testBurningToken() public {
        token.safeMint(msg.sender);
        assertEq(token.ownerOf(0), msg.sender); // Does not revert
        token.burnToken(0);
        //vm.expectRevert("ERC721: invalid token ID");
        //assertEq(token.ownerOf(0), msg.sender); // Reverts
    }
}