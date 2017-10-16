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
  - "HAZ 'HazzaNetwork Token' contract" - Sometimes spelled "Hazza Network" and sometimes "HazzaNetwork".
  - Trailing whitespaces at end of lines.
  - Consider using uint256 explicitly instead of uint. See EIP spec and other standards as reference.
  - File headers say "[...] ERC20 Token Interface" in multiple files even though those files have a different purpose.
  - Some comments start with lowercase vs uppercase.
- README.md
  - "Participants with locked tokens can called [...]" - typo.
  - "[...] and lockedTokens.unlock2() to unlock their tokens" - unlock2() does not exist in the code.
  - "Execute unlock3M() after 3 months has passed [...]" - unlock3M does not exist in the code.
- ERC20Interface.sol
  - Consider implementing the [final version of the spec](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md)
- SafeMath.sol
  - Consider marking both the add and sub functions as 'constant' or 'pure' in Solidity 0.4.17+.
- Owned.sol
  - The acceptOwnership function should raise the OwnershipTransferred event after it has done the assignment, before returning.
- HazzaNetworkToken.sol (ERC20Token contract)
  - If you decide to implement EIP20, make sure to follow the implementation details mentioned about constructor behavior, etc.
- HazzaNetworkToken.sol (HazzaNetworkToken contract)
  - Current KYC design makes it more difficult if someone can't get past KYC. How would that be handled?
  - "[...] need to be KYC verified KYC" - Typo.
  - Consider adding a Finalised event, for consistency. Currently finalize() does not fire any events.
  - "// Can only finalise once" - This comment makes sense on the 'require(!finalised)' statement but not needed again above the 'finalised = true' statement.
  - Mixed use of 'finalise' and 'finalize' in code / comments.
  - Use explicit 'public' visiblity keywords - functions addTokenBalance, ..., finalize instead of relying on default.
  - "// verification check for the crowdsale participant's first transfer" - The check is done on each transfer, not just the first one.
  - Careful with the order of things addBalance -> KYC verify -> addBalance, would reset the KYC flag to required
  - For the transfer and transferFrom methods, require(now > START_DATE); should be >=
- LockedBalances.sol
  - "// Modifier to mark that a function can only be executed by the owner" - The modifier actually restricts to calls from the token contract, not the owner.
  - Add explicit visibility specifiers
  - "// Add to 8m locked balances and totalSupply" - This comment is also present over the add12M function.
  - Theorical issue: totalSupplyLocked is calculated without overflow check so if all 3 addTokenBalance?MLocked balances wrapped around, the HazzaNetworkToken's finalize method could end up allocating a smaller number of tokens than expected balances[address(lockedTokens)] = balances[address(lockedTokens)].add(lockedTokens.totalSupplyLocked()); Consider putting a totalLocked checked in the addTokenBalance.
  - Consider firing events for the add and unlock methods, making it easier to track successful completion
<br />


## Disclaimer
This audit focused on the functionality and security aspects of the smart contracts. It does not constitute en endorsement of the
project or the business. There a many risks involved in participating on a token sale so make sure to do your own due dilligence.
The authors provide no guarantees of any kinds with regards to the accuracy or completeness of this report or its intended used.
<br />
<br />
<br />
Copyright (c) 2017 Enuma Technologies, for Octo3 Foundation.





