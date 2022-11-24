// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract VendingMachine{
    address public owner;
    mapping (address => uint) public donutBalances;

    constructor(){
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    function restockDonuts(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine");
        donutBalances[address(this)] += amount;
    }

    function purchaseDonuts(uint amount) public payable {
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ether per donut");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to fullfil purchase request");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}