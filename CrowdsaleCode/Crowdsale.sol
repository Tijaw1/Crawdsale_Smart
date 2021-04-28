pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// Inherit the Crowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale, and MintedCrowdsale contracts

contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    
    uint fakenow=now;
    
    constructor(
        // rate variable in TKNbits
        uint rate,
        // wallet parameter 
        address payable wallet,
        // the Token to be used for transaction 
        PupperCoin token,
        // create a goal parameter
        uint goal,
        // create the open and close time parameters 
        uint open,
        uint close
    )
        // Pass the constructor parameters to the crowdsale contracts
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(goal)
        TimedCrowdsale(now, now + 24 weeks)
        // fakenow parameter to be used for testing purposes only
        // TimedCrowdsale(fakenow, fakenow + 1 minutes)

        RefundableCrowdsale(goal)
        
        public
    {
        
    }
}

contract PupperCoinSaleDeployer {

    address public token_sale_address;
    address public token_address;
    uint fakenow;
    constructor(
        // constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet,
        uint goal
        // uint fakenow
    )
        public
    {
        // create PupperCoin and its address
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);

        // create PupperCoinSale and set the goal, and set the open and close times to now and now + 24 weeks.
        PupperCoinSale pupper_token = new PupperCoinSale(1, wallet, token, goal, now, now + 24 weeks);
        
        // for testing purposes, use the fakenow parameter as open time and fakenow + 5 minutes as close time
        // PupperCoinSale pupper_token = new PupperCoinSale(1, wallet, token, goal, fakenow, fakenow + 1 minutes);
        
        token_sale_address = address(pupper_token);

        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(token_sale_address);
        token.renounceMinter();
    }
}
