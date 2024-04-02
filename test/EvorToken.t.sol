// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {EvorToken} from "../src/EvorToken.sol";

contract EvorTokenTest is Test {
    EvorToken token;

    address deployer;

    uint256 private constant BURN_AMOUNT = 1e17;
    uint256 private constant INITIAL_SUPPLY = 1000e18;
    uint256 private constant TRANSFER_AMOUNT = 100e18;

    // Setup function runs before each test case
    function setUp() public {
        deployer = address(this); // In tests, the deployer is the test contract itself
        token = new EvorToken(INITIAL_SUPPLY, true); // Deploy the token with burnable enabled
    }

    // Test initial supply
    function testInitialSupply() public view {
        assertEq(token.totalSupply(), INITIAL_SUPPLY, "Initial supply mismatch");
        assertEq(token.balanceOf(deployer), INITIAL_SUPPLY, "Deployer balance mismatch");
    }

    // Test burning functionality
    function testBurn() public {
        token.burn(BURN_AMOUNT); // Burn tokens

        uint256 expectedSupply = INITIAL_SUPPLY - BURN_AMOUNT;
        assertEq(token.totalSupply(), expectedSupply, "Total supply after burn mismatch");
        assertEq(token.balanceOf(deployer), expectedSupply, "Deployer balance after burn mismatch");
    }

    // Test disabling burn function
    function testBurnDisabled() public {
        // Redeploy with burnable disabled
        token = new EvorToken(INITIAL_SUPPLY, false);

        // Attempt to burn should fail
        vm.expectRevert("Burning not enabled");
        token.burn(1e17); // Attempt to burn 0.1 token
    }
}
