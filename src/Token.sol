// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/openzeppelin-contracts/contracts/utils/Counters.sol";

import "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract Token is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Token", "T") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://brknarsy.github.io/erc721-foundry/jsons/";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function burnToken(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        pure
        override(ERC721)
        returns (string memory)
    {
        return string(abi.encodePacked(_baseURI(), Strings.toString(tokenId + 1), ".json"));
    }
}