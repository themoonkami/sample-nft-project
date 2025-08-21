// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PEPE = "ipfs://bafybeigcfboxyzf4wzr7oxzfupte4p6uew7cyr6uydt45unrehemlmiz4u.ipfs.dweb.link?filename=pepe.txt";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        // assertEq(basicNft.name(), "Pepe NFT");
        string memory expectedName = "Pepe NFT";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(actualName)) == keccak256(abi.encodePacked(expectedName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PEPE);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PEPE)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));

    }
}