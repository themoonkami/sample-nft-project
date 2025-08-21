// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant PEPE = "ipfs://bafybeigcfboxyzf4wzr7oxzfupte4p6uew7cyr6uydt45unrehemlmiz4u.ipfs.dweb.link?filename=pepe.txt";
    function run() external {
       address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("Pepe NFT", block.chainid);
       mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PEPE);
        vm.stopBroadcast();

    }
}