// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine {
    address public owner;
    mapping (address => uint) public donutBalances;
    address payable wallet; 

    constructor(address payable _wallet) {
        donutBalances[address(this)] = 100;
        owner =  msg.sender;
        wallet = _wallet;
    }

    // Get total number of donuts in macine
    function getDonutMachineBalance() public view returns (uint) {
        return donutBalances[address(this)]; 
    }

    // Refill the donnut machine
    function restock(uint amount) public {
        require(msg.sender == owner, "Onlly owner can restock the donut machine");
        donutBalances[address(this)] += amount;
    }

    // Purchase donut(s)
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 3 ether, "Please pay 3 ethers for each donut");
        require(donutBalances[address(this)] >= amount, "Not enough donuts");

        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;

        wallet.transfer(msg.value);
    }
}