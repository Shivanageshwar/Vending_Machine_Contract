// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "Vending_Machine.sol";
import "VendingMachineHandler.sol";

contract VendingMachineInvariantTest is Test {
    Vending_Machine vending;
    VendingMachineHandler handler;

    function setUp() public {
        vending = new Vending_Machine();
        handler = new VendingMachineHandler(vending);

        targetContract(address(handler));
    }

    /*//////////////////////////////////////////////////////////////
                            INVARIANTS
    //////////////////////////////////////////////////////////////*/

    // Invariant 1: Vending machine donut balance never negative
    function invariant_DonutBalanceNeverNegative() public {
        assertGe(vending.getVendingMachineBalance(), 0);
    }

    // Invariant 2: ETH balance equals donuts sold * 2 ether
    function invariant_ETHMatchesSales() public {
        uint256 totalUserDonuts =
            vending.getUserBalance(handler.user1()) +
            vending.getUserBalance(handler.user2());

        assertEq(address(vending).balance, totalUserDonuts * 2 ether);
    }

    // Invariant 3: Owner never changes
    function invariant_OwnerIsConstant() public {
        assertEq(vending.owner(), address(this));
    }
}

