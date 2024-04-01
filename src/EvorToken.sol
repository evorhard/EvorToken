// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EvorToken is ERC20 {
    bool public burnable;

    constructor(uint256 initialSupply, bool _burnable) ERC20("EvorToken", "EVOR") {
        _mint(msg.sender, initialSupply);
        burnable = _burnable;
    }

    function burn(uint256 amount) public {
        require(burnable, "Burning not enabled");
        _burn(msg.sender, amount);
    }
}
