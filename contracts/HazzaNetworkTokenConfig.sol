pragma solidity ^0.4.11;

// ----------------------------------------------------------------------------
// HAZ 'HazzaNetwork Token' contract - ERC20 Token Interface
//
// Refer to http://hazza.network for further information.
//
// Enjoy. (c) ANX International and BokkyPooBah / Bok Consulting Pty Ltd 2017.
// The MIT Licence.
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// openANX crowdsale token smart contract - configuration parameters
// ----------------------------------------------------------------------------
contract HazzaNetworkTokenConfig {

    // ------------------------------------------------------------------------
    // Token symbol(), name() and decimals()
    // ------------------------------------------------------------------------
    string public constant SYMBOL = "HAZ";
    string public constant NAME = "Hazza Network Token";
    uint8 public constant DECIMALS = 18;


    // ------------------------------------------------------------------------
    // Decimal factor for multiplications from HAZ unit to HAZ natural unit
    // ------------------------------------------------------------------------
    uint public constant DECIMALSFACTOR = 10**uint(DECIMALS);

    // ------------------------------------------------------------------------
    // total tokens
    // ------------------------------------------------------------------------
    uint public constant TOKENS_TOTAL = 100000000 * DECIMALSFACTOR;

    // ------------------------------------------------------------------------
    // Token activation start date
    // Do not use the `now` function here
    // Start - Thursday, 22-Jun-17 13:00:00 UTC / 1pm GMT 22 June 2017
    // ------------------------------------------------------------------------
    uint public constant START_DATE = 1498136400;

    // ------------------------------------------------------------------------
    // dates for locked tokens
    // Do not use the `now` function here. Will specify exact epoch for each
    // ------------------------------------------------------------------------
    uint public constant LOCKED_6M_DATE = 1498136400;
    uint public constant LOCKED_8M_DATE = 1498136400;
    uint public constant LOCKED_12M_DATE = 1498136400;

}