//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {DecentralizedStableCoin} from "./DecentarlizedStableCoin.sol";

contract DSCEngine {

    error DSCEngine__MustBeGreaterThanZero();
    error DSCEngine__InvalidToken();
    error DSCEngine__InvalidTokenLength();

    mapping(address token => address pricefeed) private s_priceFeeds;

    modifier GreaterThanZero(uint256 _amount) {
        if(_amount <= 0) {
            revert DSCEngine__MustBeGreaterThanZero();
        }
        _;
    }

    modifier isAllowedToken(address _tokenAddress) {
        if (s_priceFeeds[_tokenAddress] == address(0)) {
            revert DSCEngine__InvalidToken();
        }
        _;
    }

    constructor(address[] memory _tokenAddresses , address[] memory _priceFeeds, address _stableCoinAddress) {
        if(_tokenAddresses.length != _priceFeeds.length) {
            revert DSCEngine__InvalidTokenLength();
        }
        for (uint256 i = 0; i < _tokenAddresses.length; i++) {
            s_priceFeeds[_tokenAddresses[i]] = _priceFeeds[i];
        }
    }

    function depositCollateralAndMintDSC() external {}

    /*
    * @param _tokenCollateralAddress the address of the token collateral
    * @param _amount The amount of collateral to deposit
    */
    function depositCollateral(address _tokenCollateralAddress, uint256 _amount) external GreaterThanZero(_amount)isAllowedToken(_tokenCollateralAddress){

    }

    function redeemCollateralAndBurnDSC() external {}

    function redeemCollateral() external {}

    function burnDSC() external {}

    function liquidate() external {}

    function getHealthFactor() external view returns(uint256){}
}