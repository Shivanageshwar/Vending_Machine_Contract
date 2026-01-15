
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "Vending_Machine.sol";
import "forge-std/Test.sol";

contract VendingMachineHandler is Test {
    Vending_Machine vending;

    address public user1 = address(0x1);
    address public user2 = address(0x2);

    constructor(Vending_Machine _vending) {
        vending = _vending;

        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);
    }

    /*//////////////////////////////////////////////////////////////
                        HANDLER ACTIONS
    //////////////////////////////////////////////////////////////*/

    function purchase(uint256 amount, uint256 userSeed) public {
        address user = _getUser(userSeed);

        amount = bound(amount, 0, 10);

        uint256 cost = amount * 2 ether;

        vm.prank(user);
        if (
            amount == 0 ||
            vending.getVendingMachineBalance() < amount ||
            user.balance < cost
        ) {
            vm.expectRevert();
            vending.purchase{value: cost}(amount);
        } else {
            vending.purchase{value: cost}(amount);
        }
    }

    function restock(uint256 amount) public {
        amount = bound(amount, 0, 50);

        if (amount == 0) return;

        vending.restock(amount);
    }

    function withdraw() public {
        vending.withdraw();
    }

    /*//////////////////////////////////////////////////////////////
                            HELPERS
    //////////////////////////////////////////////////////
