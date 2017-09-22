# Hazza Network Token Contract

Website: [http://hazza.network/](http://hazza.network/)

<br />

<hr />

# Table of contents

* [Requirements](#requirements)
* [TODO](#todo)
* [Operations On The Crowdsale Contract](#operations-on-the-crowdsale-contract)
  * [Anytime](#anytime)
  * [Before Start Date](#before-start-date)
  * [After Start Date And Before End Date Or Finalised](#after-start-date-and-before-end-date-or-finalised)
  * [After Finalised](#after-finalised)
  * [After 1 Year And 2 Years](#after-1-year-and-2-years)
* [Testing](#testing)
* [Deployment Checklist](#deployment-checklist)

<br />

<hr />

# Requirements

* Token Identifier
  * symbol `HAZ`
  * name `Hazzet Network Token`
  * decimals `18`

* Total Suppy of Tokens
  * The total supply of tokens will be determined by the number of tokens sold by the end of the sale.
  * The total supply of 6 month locked tokens is: TBC
  * The total supply of 8 month locked tokens is: TBC
  * The total supply of 12 month locked tokens is: TBC

* Off Chain Public Sale of Tokens
  * The tokens sale will be conducted off-chain
  * On completion of the sale, the contract owner will make multiple calls to add 6, 8, and 12 month locked balances, and unlocked balances
  * After reconciliation, the token contract will be finalized and no further tokens can be allocated.

* KYC on unlocked balances
  * The token sale will conduct KYC on all participants. Typically all token balances will be activated at the time of finalisation, however Hazza Network has the ability to deploy balances that remained "locked" until the participant has completed their KYC process.
  * The contract assumes KYC has been completed on all locked balances prior to balance allocation.  

* `finalise()` The Token Balances
  * Hazza Network calls `finalise()` to close the allocation of balances to the contract. 
  * The `finalise()` function will allocate the 6, 8, and 12 month locked tokens
  
<br />

<hr />

## TODO

* [x] ANX unit tests
* [ ] TBC to Complete [Security Audit](SecurityAudit.md).

<br />

<hr />

# Operations On The Contract

Following are the functions that can be called at the different phases of the contract lifecycle

## Anytime

* Owner can call `kycVerify(...)` to verify participants.

## Before Start Date and Before Finalised

* Owner can call `addTokenBalance(...)` to add participant balances, and flag if KYC is required
* Owner can call `addTokenBalance[6|8|12]MLocked(...)` to add locked participant balances, assumes no KYC is required

## Before Start Date Or Finalised

* Owner can call `finalise()` to prevent the allocation of any more balances.

## After Finalised and After Start Date

* Owner calls `kycVerify(...)` to verify participants.
* Participant can call the normal `transfer(...)`, `approve(...)` and `transferFrom(...)` to transfer tokens

## After 6 months, 8 months, and 12 months

* Participants with locked tokens can called the `lockedTokens.unlock6M()` , `lockedTokens.unlock8M()` and `lockedTokens.unlock2()` to unlock their tokens
  * Find the address of the LockedTokens contract from the lockedTokens variable in the token contract
  * Watch the LockedTokens address using the LockedTokens Application Binary Interface
  * Execute `unlock3M()` after 3 months has passed, `unlock6M()` after 6 months has passed, or `unlock12M()` after 12 months has passed, to unlock the tokens

<br />

<hr />

# Testing

See [test](test) for details.

<br />

<hr />

# Deployment Checklist

* Check START_DATE
* Check Solidity [release history](https://github.com/ethereum/solidity/releases) for potential bugs 
* Deploy contract to Mainnet
* Verify the source code on EtherScan.io
  * Verify the main HazzaNetwork contract
  * Verify the LockedToken contract

<br />

<br />

# Credits

Thanks to the excellent work from BokkyPoohBah on the openANX project which was used as the template for this contract.

(c) ANX International 2017. The MIT Licence.
<br />
Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2017. The MIT Licence.


