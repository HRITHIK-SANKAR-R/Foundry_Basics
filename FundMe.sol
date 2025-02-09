//SPDX-License-Identifier:MIT

pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

//priceinusd() : give price of one eth in usd
//getConversionRate() : gives price of the ETH fund in the form of usd.
//getVersion() : gives version of the contract which we use to convert from one Blockchain value to USD


contract FundMe{
    using PriceConverter for uint256;
    uint256 l=5e18;
    address[] public senders;
    mapping(address funder=> uint256 amtFunded)  public fundinfo;






    function fund() public payable{
        require(msg.value.getConversionRate()>l,"Didn't send Enough ETH");
        //Adding senders to the address list
        senders.push(msg.sender); //msg.sender helps to get address of the sender
        fundinfo[msg.sender]+=msg.value.getConversionRate();
    }

    function withdraw() public {
         for (uint256 fuIndex=0;fuIndex<senders.length;fuIndex++){
            fundinfo[senders[fuIndex]]=0;
        }
        senders=new address[](0);
    }
    
}