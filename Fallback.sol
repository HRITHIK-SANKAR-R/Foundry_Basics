//SPDX-License-Identifier: MIT
pragma solidity^0.8.24;

contract Fallback{
    uint256 public result;

    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()

    receive() external payable{
        result =1;
    }
    fallback() external payable{
        result=2;
    }
}