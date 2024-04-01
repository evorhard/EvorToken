// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {EvorToken} from "../src/EvorToken.sol";

contract DeployEvorToken is Script {
    function run(uint256 initialSupply, bool burnable) external {
        vm.startBroadcast();

        EvorToken token = new EvorToken(initialSupply, burnable);

        console.log("Deployed EvorToken at:", address(token));
        console.log("Burnable:", burnable ? "YES" : "NO");

        vm.stopBroadcast();
    }
}
