# Crawdsale_Smart

![crowd](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/crowd.png)

## Background

A company has decided to crowdsale their PupperCoin token in order to help fund the network development.
This network will be used to track the dog breeding activity across the globe in a decentralized way, and allow humans to track the genetic trail of their pets. You have already worked with the necessary legal bodies and have the green light on creating a crowdsale open to the public. However, you are required to enable refunds if the crowdsale is successful and the goal is met, and you are only allowed to raise a maximum of 300 Ether. The crowdsale will run for 24 weeks.

ERC20 token will be minted through a `Crowdsale` contract that can leverage from the OpenZeppelin Solidity library.

This crowdsale contract will manage the entire process, allowing users to send ETH and get back PUP (PupperCoin).
This contract will mint the tokens automatically and distribute them to buyers in one transaction.

It will need to inherit `Crowdsale`, `CappedCrowdsale`, `TimedCrowdsale`, `RefundableCrowdsale`, and `MintedCrowdsale`.

You will conduct the crowdsale on the Kovan or Ropsten testnet in order to get a real-world pre-production test in.

## Instructions

### Designing the contracts

#### ERC20 PupperCoin

Use a standard `ERC20Mintable` and `ERC20Detailed` contract, hardcoding `18` as the `decimals` parameter, and leaving the `initial_supply` parameter alone.

#### PupperCoinCrowdsale

Bootstrap the contract by inheriting the following OpenZeppelin contracts:

* `Crowdsale`

* `MintedCrowdsale`

* `CappedCrowdsale`

* `TimedCrowdsale`

* `RefundablePostDeliveryCrowdsale`

Provide parameters for all of the features of the crowdsale, such as the `name`, `symbol`, `wallet` for fundraising, `goal`, etc. Feel free to configure these parameters to your liking.

The `rate` can be hard codded to 1, to maintain parity with Ether units (1 TKN per Ether, or 1 TKNbit per wei). If you'd like to customize your crowdsale rate, follow the [Crowdsale Rate](https://docs.openzeppelin.com/contracts/2.x/crowdsales#crowdsale-rate) calculator on OpenZeppelin's documentation. Essentially, a token (TKN) can be divided into TKNbits just like Ether can be divided into wei. When using a `rate` of 1, just like 1000000000000000000 wei is equal to 1 Ether, 1000000000000000000 TKNbits is equal to 1 TKN.

Since `RefundablePostDeliveryCrowdsale` inherits the `RefundableCrowdsale` contract, which requires a `goal` parameter, you must call the `RefundableCrowdsale` constructor from your `PupperCoinCrowdsale` constructor as well as the others. `RefundablePostDeliveryCrowdsale` does not have its own constructor, so just use the `RefundableCrowdsale` constructor that it inherits.

If you forget to call the `RefundableCrowdsale` constructor, the `RefundablePostDeliveryCrowdsale` will fail since it relies on it (it inherits from `RefundableCrowdsale`), and does not have its own constructor.

When passing the `open` and `close` times, use `now` and `now + 24 weeks` to set the times properly from your `PupperCoinCrowdsaleDeployer` contract.

#### PupperCoinCrowdsaleDeployer

In this contract, you will model the deployment based off of the `ArcadeTokenCrowdsaleDeployer` you built previously. Leverage the [OpenZeppelin Crowdsale Documentation](https://docs.openzeppelin.com/contracts/2.x/crowdsales) for an example of a contract deploying another, as well as the starter code provided in [Crowdsale.sol](../Starter-Code/Crowdsale.sol).

![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-1.PNG)

### Testing the Crowdsale

Test the crowdsale by sending Ether to the crowdsale from a different account (**not** the same account that is raising funds), then once it has been confirmed that the crowdsale works as expected, try to add the token to MyCrypto and test a transaction. You can test the time functionality by replacing `now` with `fakenow`, and creating a setter function to modify `fakenow` to whatever time you want to simulate. You can also set the `close` time to be `now + 5 minutes`, or whatever timeline you'd like to test for a shorter crowdsale.

When sending Ether to the contract, make sure that the `goal` is achieved, and `finalize` the sale using the `Crowdsale`'s `finalize` function. In order to finalize, `isOpen` must return false (`isOpen` comes from `TimedCrowdsale` which checks to see if the `close` time has passed yet). Since the `goal` is 300 Ether, you may need to send from multiple accounts. If you run out of prefunded accounts in Ganache, you can create a new workspace.

Remember, the refund feature of `RefundablePostDeliveryCrowdsale` only allows for refunds once the crowdsale is closed **and** the goal is met. See the [OpenZeppelin RefundableCrowdsale](https://docs.openzeppelin.com/contracts/2.x/api/crowdsale#RefundableCrowdsale) documentation for details as to why this is logic is used to prevent potential attacks on your token's value.

You can add custom tokens in MyCrypto from the `Add custom token` feature:

![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-2.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-3.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-4.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-5.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-6.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-7.PNG)

You can also do the same for MetaMask. Make sure to purchase higher amounts of tokens in order to see the denomination appear in your wallets as more than a few wei worth.

### Deploying the Crowdsale

Deploy the crowdsale to the Kovan or Ropsten testnet, and store the deployed address for later. Switch MetaMask to your desired network, and use the `Deploy` tab in Remix to deploy your contracts. Take note of the total gas cost, and compare it to how costly it would be in reality. Since you are deploying to a network that you don't have control over, faucets will not likely give out 300 test Ether. You can simply reduce the goal when deploying to a testnet to an amount much smaller, like 10,000 wei. In this case, the contract is deployed in Ropsten testnet.

![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-8.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-9.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-10.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-11.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-12.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-13.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-14.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-15.PNG)
![PupperCoinCrowdsaleDeployer](https://github.com/Tijaw1/Crawdsale_Smart/blob/main/ScreenShots/21-16.PNG)

