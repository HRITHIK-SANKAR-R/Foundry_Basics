//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//priceinusd() : give price of one eth in usd
//getConversionRate() : gives price of the ETH fund in the form of usd.
//getVersion() : gives version of the contract which we use to convert from one Blockchain value to USD


contract FundMe{

    uint256 l=5e18;
    address[] public senders;
    mapping(address funder=> uint256 amtFunded)  public fundinfo;






    function fund() public payable{
        require(getConversionRate(msg.value)>l,"Didn't send Enough ETH");
        //Adding senders to the address list
        senders.push(msg.sender); //msg.sender hepls to get address of the sender
        fundinfo[msg.sender]+=getConversionRate(msg.value);
    }

    function withdraw() public {
        
    }

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