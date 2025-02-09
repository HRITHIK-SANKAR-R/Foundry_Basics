//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function priceinusd() public view returns(uint256){
        //0x694AA1769357215DE4FAC081bf1f309aDC325306

        AggregatorV3Interface pricefeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,)=pricefeed.latestRoundData();
        return uint256(price*1e10);
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){ 
        return (priceinusd()*ethAmount)/1e18;

    }

    function Getversion() public view returns(uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
    
}