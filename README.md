🧁 Vending Machine Smart Contract

A simple Solidity smart contract that simulates a blockchain-based vending machine. It allows users to purchase donuts using Ether, while only the owner can restock or withdraw funds.

📜 Overview

This smart contract represents a vending machine where:

The owner can restock donuts and withdraw collected Ether.

Users can purchase donuts using Ether (2 ETH per donut).

The contract keeps track of both the machine's stock and each user's donut balance.

⚙️ Features

👤 Owner Functions

restock(uint amount) → Adds more donuts to the machine.

withdraw() → Withdraws all Ether from the contract to the owner’s wallet.

💰 User Functions

purchase(uint amount) → Buy donuts by paying 2 ETH per donut.

getUserBalance(address _user) → View your donut balance.

getVendingMachineBalance() → Check how many donuts are in the machine.

🚫 Error Handling with Custom Errors

OnlyOwnerCanRestock()

InsufficientPayment()

NotEnoughDonutsInStock()

OnlyOwnerCanWithdraw()

🧩 Contract Details
Variable	Type	Description
owner	address	Stores the contract owner’s address.
donutBalances	mapping(address => uint)	Tracks donuts owned by users and stock in the machine.
💵 Donut Price

Each donut costs 2 Ether.

Example:

Buying 3 donuts = 3 * 2 = 6 ETH

vendingMachine.purchase{value: 6 ether}(3);

🔐 Access Control
Function	Access
restock()	Only Owner
withdraw()	Only Owner
purchase()	Any User
getVendingMachineBalance()	Public
getUserBalance()	Public
🧠 How It Works

Deployment:

Owner is set to the deployer’s address.

Machine starts with 100 donuts.

Buying Donuts:

Send exactly amount * 2 ether with your transaction.

The machine transfers donuts to your balance.

Restocking:

Only the owner can restock donuts when stock runs low.

Withdraw:

Owner can withdraw all Ether collected from sales.

🧪 Example (Remix IDE)

Deploy the contract using Remix.

Check stock:

getVendingMachineBalance()


Purchase 2 donuts:

Enter 2 in the input.

Send 4 ether in the value field.

purchase(2)


Check your donut balance:

getUserBalance(your_address)


Restock (only owner):

restock(50)


Withdraw funds (only owner):

withdraw()

🧰 Requirements

Solidity Version: ^0.8.26

Network: Any EVM-compatible blockchain (e.g., Ethereum, Sepolia, or local Hardhat/Remix testnet).

👨‍💻 Author

Shiva Nageshwar

🎯 Aspiring Smart Contract & Web3 Developer

💻 Built with Solidity & deployed via Remix IDE

🪙 License

This project is licensed under the MIT License.
