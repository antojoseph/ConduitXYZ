// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

import { IAllocatorConduit } from "../lib/dss-allocator/src/interfaces/IAllocatorConduit.sol";
interface StrategyManager{
    function depositIntoStrategy(address strategy,address token,uint256 amount) external view returns (uint256 shares);
    function queueWithdrawal(uint256 index,address stratergie,uint256 shares,address withdrawer,bool undelegateifPossible) external view returns (bytes calldata withdrawalroot);
    function completeQueuedWithdrawals(bytes[] calldata quedwithdrawals,uint256[] calldata middlewareIndexes,bool receiveastokens) external view ;
}

interface rocketPoolETH{
    function approve(address spender_, uint256 amount_)  external returns (bool success_);
    function balanceOf(address account) external returns(uint256 balance);
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
}


contract CroissantProtocol is IAllocatorConduit {

    rocketPoolETH rETH = rocketPoolETH(0xae78736Cd615f374D3085123A210448E74Fc6393);
    StrategyManager eigenLayer = StrategyManager(0x858646372CC42E1A627fcE94aa7A7033e7CF075A);
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

   function restake() external{
        rETH.approve(address(0x1BeE69b7dFFfA4E2d53C2a2Df135C388AD25dCD2),1000000000000000000000);
        rETH.approve(address(0x858646372CC42E1A627fcE94aa7A7033e7CF075A),1000000000000000000000);

   }

      /**
     *  @dev   Function for withdrawing tokens from a Fund Manager.
     *  @param  ilk         The unique identifier of the ilk.
     *  @param  asset       The asset to withdraw.
     *  @param  maxAmount   The max amount of tokens to withdraw. Setting to "type(uint256).max" will ensure to withdraw all available liquidity.
     *  @return amount      The amount of tokens withdrawn.
     */

    function withdraw(bytes32 ilk, address asset, uint256 maxAmount) external returns (uint256 amount){
        eigenLayer.queueWithdrawal(1,address(1),1,address(1),true );
     return amount;
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
    
    return 200 ether;
    }
}