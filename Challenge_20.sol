// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract JointSavings {
    // Declare two payable addresses for the joint account holders
    address payable accountOne;
    address payable accountTwo;

    // Variables to keep track of the last withdrawal recipient, amount, and contract balance
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;
    
    // Function to allow a withdrawal from the joint account
    function withdraw(uint amount, address payable recipient) public {
        // Require that the recipient is one of the account holders
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        
        // Require that the contract has sufficient funds for the withdrawal
        require(address(this).balance >= amount, "Insufficient funds!");
        
        // Update the last withdrawal recipient if it's different from the current one
        if (lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }
        
        // Transfer the specified amount to the recipient
        recipient.transfer(amount);
        
        // Update the last withdrawal amount and contract balance
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }
    
    // Function to deposit ether into the joint account
    function deposit() public payable {
        // Update the contract balance with the received amount
        contractBalance = address(this).balance;
    }

    // Function to set the account addresses for the joint account
    function setAccounts(address payable account1, address payable account2) public {
        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2`, respectively
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function to allow the contract to receive ether
    function() external payable {}
}
