// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

import { IAllocatorConduit } from "../lib/dss-allocator/src/interfaces/IAllocatorConduit.sol";
contract CroissantProtocol is IAllocatorConduit {

   /**
     *  @dev   Function for depositing tokens into a Fund Manager.
     *  @param ilk    The unique identifier of the ilk.
     *  @param asset  The asset to deposit.
     *  @param amount The amount of tokens to deposit.
     */

   function deposit(bytes32 ilk, address asset, uint256 amount) external {

        address mock_source = address(this);

     emit Deposit(ilk, asset, mock_source, amount);
   }

      /**
     *  @dev   Function for withdrawing tokens from a Fund Manager.
     *  @param  ilk         The unique identifier of the ilk.
     *  @param  asset       The asset to withdraw.
     *  @param  maxAmount   The max amount of tokens to withdraw. Setting to "type(uint256).max" will ensure to withdraw all available liquidity.
     *  @return amount      The amount of tokens withdrawn.
     */

    function withdraw(bytes32 ilk, address asset, uint256 maxAmount) external returns (uint256 amount){

     return 200 ether;
     }

    /**
     *  @dev    Function to get the maximum deposit possible for a specific asset and ilk.
     *  @param  ilk         The unique identifier of the ilk.
     *  @param  asset       The asset to check.
     *  @return maxDeposit_ The maximum possible deposit for the asset.
     */


    function maxDeposit(bytes32 ilk, address asset) external view returns (uint256 maxDeposit_){

     return 200 ether;
    }



    /**
     *  @dev    Function to get the maximum withdrawal possible for a specific asset and ilk.
     *  @param  ilk          The unique identifier of the ilk.
     *  @param  asset        The asset to check.
     *  @return maxWithdraw_ The maximum possible withdrawal for the asset.
     */


    function maxWithdraw(bytes32 ilk, address asset) external view returns (uint256 maxWithdraw_){
    
    return maxWithdraw_/50 ether;
    }
}