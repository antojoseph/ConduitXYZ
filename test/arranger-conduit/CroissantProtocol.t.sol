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

interface CoinbaseStakedETH{
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
    CoinbaseStakedETH cbETH;
    function setUp() public virtual {
        conduitImplementation = new CroissantProtocol();
        asset = new MockERC20("asset", "ASSET", 18);
        asset.mint(address(conduitImplementation), 100 ether);
        

    }
     function test_conduit() public {
       console.log(address(conduitImplementation));
       console.log(asset.balanceOf(address(conduitImplementation)));
       conduitImplementation.deposit('0xilk', address(conduitImplementation), 10 ether);

        // approve LST to EigenLayer Stratergy Manager
        cbETH = CoinbaseStakedETH(0xBe9895146f7AF43049ca1c1AE358B0541Ea49704);
        cbETH.approve(0x858646372CC42E1A627fcE94aa7A7033e7CF075A, 10 ether);

        // Become the largest cbETH HODLR
         vm.startPrank(0xED1F7bb04D2BA2b6EbE087026F03C96Ea2c357A8);
        cbETH.transfer(address(conduitImplementation), 10 ether);
        console.log(cbETH.balanceOf(address(conduitImplementation)));
        vm.stopPrank();



        
        // Deposit into the stratergy
        eigenLayer = StrategyManager(0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45);
        eigenLayer.depositIntoStrategy(0x54945180dB7943c0ed0FEE7EdaB2Bd24620256bc,0xBe9895146f7AF43049ca1c1AE358B0541Ea49704,0.000001 ether);
        



    }


}