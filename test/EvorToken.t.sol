// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {EvorToken} from "../src/EvorToken.sol";

contract EvorTokenTest is Test {
    EvorToken evorToken;

    address deployer;
    address userOne = address(0x1);

    uint256 private constant INITIAL_SUPPLY = 1000e18;
    uint256 private constant TRANSFER_AMOUNT = 100e18;

    function setUp() public {
        deployer = address(this);
        evorToken = new EvorToken(INITIAL_SUPPLY);
    }

    function testInitialSupply() public view {
        // Check that the deployer has the entire initial supply
        assertEq(evorToken.balanceOf(deployer), INITIAL_SUPPLY);
    }

    function testTransfer() public {
        // Transfer 100 tokens from deployer to userOne
        evorToken.transfer(userOne, TRANSFER_AMOUNT);

        // Check that the deployer has 900 tokens
        // And userOne has 100 tokens
        assertEq(evorToken.balanceOf(deployer), INITIAL_SUPPLY - TRANSFER_AMOUNT);
        assertEq(evorToken.balanceOf(userOne), TRANSFER_AMOUNT);
    }
}
