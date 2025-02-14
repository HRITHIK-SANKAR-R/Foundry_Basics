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
    address owner;


    constructor(){
        owner=msg.sender;
    }


    function fund() public payable{
        require(msg.value.getConversionRate()>l,"Didn't send Enough ETH");
        //Adding senders to the address list
        senders.push(msg.sender); //msg.sender helps to get address of the sender
        fundinfo[msg.sender]+=msg.value.getConversionRate();
    }



    function withdraw() public checkowner {
        
         for (uint256 fuIndex=0;fuIndex<senders.length;fuIndex++){
            fundinfo[senders[fuIndex]]=0;
        }
        senders=new address[](0);
    //(msg.sender).transfer.(address(this).balance) -- Easiest way to transfer money 2300 gas.If not transacted returns error.
    payable(msg.sender).transfer(address(this).balance);
    //(msg.sender).transfer.(address(this).balance) -- Returns bool value to transfer money 2300 gas.
    bool success=payable(msg.sender).send(address(this).balance);
    //(msg.sender).call{value:address(this).balance}(function); -Returns bool and value of called function.
    (bool sendsuccess,)=payable(msg.sender).call{value:address(this).balance}("");
    }

    modifier checkowner(){
        require(msg.sender==owner,"Must be a owner");
        _;
    }
    
}