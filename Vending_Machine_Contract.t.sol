// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/Vending_Machine.sol";

contract VendingMachineTest is Test {
    Vending_Machine vending;

    address owner = address(this);
    address user = address(0x1);

    function setUp() public {
        vending = new Vending_Machine();

        vm.deal(user, 100 ether);
    }

    /*//////////////////////////////////////////////////////////////
                            DEPLOYMENT
    //////////////////////////////////////////////////////////////*/

    function testInitialStockIs100() public {
        assertEq(vending.getVendingMachineBalance(), 100);
    }

    function testOwnerIsCorrect() public {
        assertEq(vending.owner(), owner);
    }

    /*//////////////////////////////////////////////////////////////
                            RESTOCK
    //////////////////////////////////////////////////////////////*/

    function testOwnerCanRestock() public {
        vending.restock(50);
        assertEq(vending.getVendingMachineBalance(), 150);
    }

    function testNonOwnerCannotRestock() public {
        vm.prank(user);
        vm.expectRevert(Vending_Machine.OnlyOwnerCanRestock.selector);
        vending.restock(10);
    }

    /*//////////////////////////////////////////////////////////////
                            PURCHASE
    //////////////////////////////////////////////////////////////*/

    function testPurchaseSuccess() public {
        vm.prank(user);
        vending.purchase{value: 4 ether}(2);

        assertEq(vending.getUserBalance(user), 2);
        assertEq(vending.getVendingMachineBalance(), 98);
    }

    function testPurchaseRevertsIfWrongETH() public {
        vm.prank(user);
        vm.expectRevert(Vending_Machine.InsufficientPayment.selector);
        vending.purchase{value: 1 ether}(1);
    }

    function testPurchaseRevertsIfNotEnoughStock() public {
        vm.prank(user);
        vm.expectRevert(Vending_Machine.NotEnoughDonutsInStock.selector);
        vending.purchase{value: 202 ether}(101);
    }

    /*//////////////////////////////////////////////////////////////
                            WITHDRAW
    //////////////////////////////////////////////////////////////*/

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(user);
        vm.expectRevert(Vending_Machine.OnlyOwnerCanWithdraw.selector);
        vending.withdraw();
    }

    function testWithdrawTransfersETHToOwner() public {
        vm.prank(user);
        vending.purchase{value: 4 ether}(2);

        uint256 ownerBalanceBefore = owner.balance;

        vending.withdraw();

        assertEq(owner.balance, ownerBalanceBefore + 4 ether);
        assertEq(address(vending).balance, 0);
    }
}
