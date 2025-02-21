// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/utils/Counters.sol";
import "lib/openzeppelin-contracts/contracts/utils/Base64.sol";
import "lib/openzeppelin-contracts/contracts/utils/Strings.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract CertificateNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;
    
    Counters.Counter private _tokenIdCounter;

    event Minted(uint256 indexed tokenId, address indexed to);

    error CannotTransfer();
    error CannotApprove();
    error CannotApprovalForAll();

    constructor() ERC721("Muslim Al Fatih", "MAF") {}

    function mintNFT(
        address to, 
        string memory imageUrl
    ) public onlyOwner returns (uint256) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();

        _safeMint(to, tokenId);

        // Construct metadata JSON
        string memory metadata = string(abi.encodePacked(
            '{"name": "Mandala Academy NFT #', tokenId.toString(),
            '", "description": "A certificate NFT that student already completed the course", ',
            '"image": "', imageUrl, '"}'
        ));

        // Set token URI
        _setTokenURI(tokenId, string(abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(bytes(metadata))
        )));

        emit Minted(tokenId, to);
        return tokenId;
    }

    // Transfer blocking
    function transferFrom(address, address, uint256) 
        public 
        pure 
        override(ERC721, IERC721) 
    {
        revert CannotTransfer();
    }

    function safeTransferFrom(address, address, uint256, bytes memory) 
        public 
        pure 
        override(ERC721, IERC721) 
    {
        revert CannotTransfer();
    }

    function safeTransferFrom(address, address, uint256) 
        public 
        pure 
        override(ERC721, IERC721) 
    {
        revert CannotTransfer();
    }

    // Approval blocking
    function approve(address, uint256) 
        public 
        pure 
        override(ERC721, IERC721) 
    {
        revert CannotApprove();
    }

    function setApprovalForAll(address, bool) 
        public 
        pure 
        override(ERC721, IERC721) 
    {
        revert CannotApprovalForAll();
    }
}