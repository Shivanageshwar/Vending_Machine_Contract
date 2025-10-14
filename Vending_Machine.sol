// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Vending_Machine {

    // Custom Errors
    error OnlyOwnerCanRestock();
    error InsufficientPayment();
    error NotEnoughDonutsInStock();
    error OnlyOwnerCanWithdraw();

    address public owner;
    mapping(address => uint) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100; // Initial donuts in the machine
    }

    // View machine’s donut stock
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }

    // View a user’s donut balance
    function getUserBalance(address _user) public view returns (uint) {
        return donutBalances[_user];
    }

    // Only owner can restock
    function restock(uint amount) public {
        if (msg.sender != owner) {
            revert OnlyOwnerCanRestock();
        }
        donutBalances[address(this)] += amount;
    }

    // Purchase donuts
    function purchase(uint amount) public payable {
        // Each donut costs 2 ether
        if (msg.value != amount * 2 ether) {
            revert InsufficientPayment();
        }

        // Check machine has enough donuts
        if (donutBalances[address(this)] < amount) {
            revert NotEnoughDonutsInStock();
        }

        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }

    //only owner can withdraw
    function withdraw() public {
        if(msg.sender != owner) {
            revert OnlyOwnerCanWithdraw();
        }
        payable(owner).transfer(address(this).balance);
    }
}
