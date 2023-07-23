// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

import { console2 as console } from "../../lib/forge-std/src/console2.sol";
import { stdError }            from "../../lib/forge-std/src/StdError.sol";
import { Test }                from "../../lib/forge-std/src/Test.sol";
interface usdc{
    function balanceOf(address account) external returns (uint256 balance);
}
contract testhistoricalblocks is Test {
    usdc token;


   function setUp() public virtual {
    token = usdc(address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48));
   }

   function test_storageVar() public virtual {
        console.log(token.balanceOf(0xcEe284F754E854890e311e3280b767F80797180d));
   }
}
