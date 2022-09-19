// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GlobiumToken is ERC20{
        constructor(uint256 initialSupply, string memory name, string memory _id) ERC20(name, _id) {
            _mint(msg.sender, initialSupply);
        }
}