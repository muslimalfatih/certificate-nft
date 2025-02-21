// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CertificateNFT.sol";

contract CertificateNFTTest is Test {
    CertificateNFT public nft;
    address public owner;
    address public user;

    function setUp() public {
        owner = address(this);
        user = address(0x1);
        nft = new CertificateNFT();
    }

    function testMint() public {
        string memory imageUrl = "https://example.com/image.png";
        uint256 tokenId = nft.mintNFT(user, imageUrl);
        assertEq(nft.ownerOf(tokenId), user);
    }

    function testCannotTransfer() public {
        string memory imageUrl = "https://example.com/image.png";
        uint256 tokenId = nft.mintNFT(user, imageUrl);
        
        vm.startPrank(user);
        vm.expectRevert(CertificateNFT.CannotTransfer.selector);
        nft.transferFrom(user, address(0x2), tokenId);
    }

    function testCannotApprove() public {
        string memory imageUrl = "https://example.com/image.png";
        uint256 tokenId = nft.mintNFT(user, imageUrl);
        
        vm.startPrank(user);
        vm.expectRevert(CertificateNFT.CannotApprove.selector);
        nft.approve(address(0x2), tokenId);
    }

    function testOnlyOwnerCanMint() public {
        vm.startPrank(user);
        vm.expectRevert("Ownable: caller is not the owner");
        nft.mintNFT(user, "https://example.com/image.png");
    }
} 