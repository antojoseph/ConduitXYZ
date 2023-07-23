// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;
import { IArrangerConduit } from "../../src/interfaces/IArrangerConduit.sol";
import { CroissantProtocol }  from "../../src/CroissantProtocol.sol";
import { console2 as console } from "../../lib/forge-std/src/console2.sol";
import { stdError }            from "../../lib/forge-std/src/StdError.sol";
import { Test }                from "../../lib/forge-std/src/Test.sol";
import { MockERC20 } from "../../lib/mock-erc20/src/MockERC20.sol";


interface StrategyManager{
    function depositIntoStrategy(address strategy,address token,uint256 amount) external view returns (uint256 shares);
}

interface rocketPoolETH{
    function approve(address spender_, uint256 amount_)  external returns (bool success_);
    function balanceOf(address account) external returns(uint256 balance);
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
}

contract CroissantProtocolTest is Test {

    address admin    = makeAddr("admin");
    address arranger = makeAddr("arranger");

    CroissantProtocol  conduitImplementation;
    MockERC20 asset;
    StrategyManager eigenLayer;
    rocketPoolETH rETH;
    
    address attacker = address(0x7E3B29f2eaAFA9008a2C60a2e107a0E6487A7628);

    function setUp() public virtual {
        conduitImplementation = new CroissantProtocol();
        rETH = rocketPoolETH(0xae78736Cd615f374D3085123A210448E74Fc6393);
        eigenLayer = StrategyManager(0x858646372CC42E1A627fcE94aa7A7033e7CF075A);


    }
     function test_conduit() public {
        asset = new MockERC20("asset", "ASSET", 18);
        asset.mint(address(conduitImplementation), 100 ether);
       console.log(address(conduitImplementation));
       console.log(asset.balanceOf(address(conduitImplementation)));
       conduitImplementation.deposit('0xilk', address(conduitImplementation), 10 ether);
       

    }
    

    function test_get_LST_restake() public {
        vm.prank(address(0xBA12222222228d8Ba445958a75a0704d566BF2C8));
        rETH.transfer(address(conduitImplementation), 100000000000000);
        vm.prank(address(0xBA12222222228d8Ba445958a75a0704d566BF2C8));
        rETH.approve(address(this),1000000000000000000000);
        rETH.transferFrom(0xBA12222222228d8Ba445958a75a0704d566BF2C8,address(this), 100000000000000);
        rETH.approve(address(0x1BeE69b7dFFfA4E2d53C2a2Df135C388AD25dCD2),1000000000000000000000);
        rETH.approve(address(0x858646372CC42E1A627fcE94aa7A7033e7CF075A),1000000000000000000000);

         // approve LST to EigenLayer Stratergy Manager
        console.log("rETH balance:");
        console.log(rETH.balanceOf(address(conduitImplementation)));
        //vm.startPrank(address(0x7E3B29f2eaAFA9008a2C60a2e107a0E6487A7628));
        conduitImplementation.restake();
        vm.prank(address(0xBA12222222228d8Ba445958a75a0704d566BF2C8));
        eigenLayer.depositIntoStrategy(0x1BeE69b7dFFfA4E2d53C2a2Df135C388AD25dCD2,0xae78736Cd615f374D3085123A210448E74Fc6393,10);
    }

    function test_withdraw(bytes32 ilk, address asset, uint256 maxAmount) public {
        conduitImplementation.withdraw(ilk,  asset,  maxAmount); 
    }

}