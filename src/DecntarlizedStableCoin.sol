//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedStableCoin  is ERC20Burnable, Ownable{
    uint256 public constant DECIMALS = 18;

    error DecentralizedStableCoin__MustBeGreaterThanZero(); 
    error DecentralizedStableCoin__BurnAmountExceedsBalance();
    error DecentralizedStableCoin__NotZeroAddress();

    constructor()ERC20("ATHARV","ATH")Ownable(msg.sender){}

    function burn(uint256 _amount) public override onlyOwner{
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0){
            revert DecentralizedStableCoin__MustBeGreaterThanZero(); 
        }
        if(_amount > balance){
            revert DecentralizedStableCoin__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool){
        if(_to == address(0)){
            revert DecentralizedStableCoin__NotZeroAddress();
        }
        if(_amount <= 0){
            revert DecentralizedStableCoin__MustBeGreaterThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}