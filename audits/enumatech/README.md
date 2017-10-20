20th October - ANX INTL
useful audit report from Enuma. Due to client's suggestion that project time frames are not flexible, and 
no major findings were reported: only cosmetic changes have been adopted.


# Hazza Network Token Sale - Contract Audit

## Intro
Octo3 is doing a token sale for their global unified payment network, the [Hazza Network](https://hazza.network/).

Enuma Technologies was contracted to conduct an audit on the Ethereum smart contracts used during the sale and for managing the tokens.
<br />
<br />

## Report
### First review
#### **Low Severity**
- [Multiple .sol files]
  - "pragma solidity ^0.4.11;" - Suggest moving to a newer version of the Solidity compiler (e.g. 0.4.15 or later). See http://solidity.readthedocs.io/en/develop/bugs.html for known bugs on specific versions of the compiler.
  > Action: updated to 0.4.15 exactly
  - "HAZ 'Hazza Network Token' contract" - Sometimes spelled "Hazza Network" and sometimes "HazzaNetwork".
  > Action: comments updated
  - Trailing whitespaces at end of lines.
  > No Action
  - Consider using uint256 explicitly instead of uint. See EIP spec and other standards as reference.
  > No Action
  - File headers say "[...] ERC20 Token Interface" in multiple files even though those files have a different purpose.
  > Action: Updated with more meaningful comments
  
  - Some comments start with lowercase vs uppercase.
- README.md
  - "Participants with locked tokens can called [...]" - typo.
  > Action: Typo fixed
  - "[...] and lockedTokens.unlock2() to unlock their tokens" - unlock2() does not exist in the code.
  > Action: Typo fixed
  - "Execute unlock3M() after 3 months has passed [...]" - unlock3M does not exist in the code.
  > Action: Typo fixed
- ERC20Interface.sol
  - Consider implementing the [final version of the spec](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md)
  > No Action (avoiding non critical code changes)
- SafeMath.sol
  - Consider marking both the add and sub functions as 'constant' or 'pure' in Solidity 0.4.17+.
  > No Action (avoiding non critical code changes)
- Owned.sol
  - The acceptOwnership function should raise the OwnershipTransferred event after it has done the assignment, before returning.
  > No Action (avoiding non critical code changes)
- HazzaNetworkToken.sol (ERC20Token contract)
  - If you decide to implement EIP20, make sure to follow the implementation details mentioned about constructor behavior, etc.
  > No Action (avoiding non critical code changes)
- HazzaNetworkToken.sol (HazzaNetworkToken contract)
  - Current KYC design makes it more difficult if someone can't get past KYC. How would that be handled?
  > No Action: Client understands this feature. Most if not all contributors should be KYC complete before the contract is finalized.
  - "[...] need to be KYC verified KYC" - Typo.
  > Action: Typo fixed
  - Consider adding a Finalised event, for consistency. Currently finalize() does not fire any events.
  > No Action (avoiding non critical code changes)
  - "// Can only finalise once" - This comment makes sense on the 'require(!finalised)' statement but not needed again above the 'finalised = true' statement.
  > Action: removed superfluous comment
  - Mixed use of 'finalise' and 'finalize' in code / comments.
  > No Action
  - Use explicit 'public' visiblity keywords - functions addTokenBalance, ..., finalize instead of relying on default.
  > No Action (avoiding non critical code changes)
  - "// verification check for the crowdsale participant's first transfer" - The check is done on each transfer, not just the first one.
  > Action: comment removed
  - Careful with the order of things addBalance -> KYC verify -> addBalance, would reset the KYC flag to required
  > No Action: feature understood
  - For the transfer and transferFrom methods, require(now > START_DATE); should be >=
  > No Action, can't transfer until -after- start date
- LockedBalances.sol
  - "// Modifier to mark that a function can only be executed by the owner" - The modifier actually restricts to calls from the token contract, not the owner.
  > Action: comment adjusted
  - Add explicit visibility specifiers
  > No Action (avoiding non critical code changes)
  - "// Add to 8m locked balances and totalSupply" - This comment is also present over the add12M function.
  > Action: comment fixed  
  - Theorical issue: totalSupplyLocked is calculated without overflow check so if all 3 addTokenBalance?MLocked balances wrapped around, the HazzaNetworkToken's finalize method could end up allocating a smaller number of tokens than expected balances[address(lockedTokens)] = balances[address(lockedTokens)].add(lockedTokens.totalSupplyLocked()); Consider putting a totalLocked checked in the addTokenBalance.
  > No Action (avoiding non critical code changes, and contract would not pass reconcile and be finalised in this scenario)
  - Consider firing events for the add and unlock methods, making it easier to track successful completion
  > No Action (avoiding non critical code changes)
<br />


## Disclaimer
This audit focused on the functionality and security aspects of the smart contracts. It does not constitute en endorsement of the
project or the business. There a many risks involved in participating on a token sale so make sure to do your own due dilligence.
The authors provide no guarantees of any kinds with regards to the accuracy or completeness of this report or its intended used.
<br />
<br />
<br />
Copyright (c) 2017 Enuma Technologies, for Octo3 Foundation.





