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
// Hazza Network crowdsale token smart contract - configuration parameters
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
    // Token activation start date
    // Do not use the `now` function here
    // Start - Nov 8 0000 HKT; Nov 7 1600 GMT
    // ------------------------------------------------------------------------
    uint public constant START_DATE = 1507773631; // Thu Oct 12 02:00:31 UTC 2017

    // ------------------------------------------------------------------------
    // dates for locked tokens
    // Do not use the `now` function here. Will specify exact epoch for each
    // 6M  1/5/2018 0000 HKT; 30/4/2018 1600 GMT
    // 8M  1/7/2018 0000 HKT - 30/6/2018 1600 GMT
    // 12M 1/11/2018 0000 HKT; 31/10/2018 1600 GMT
    // ------------------------------------------------------------------------
    uint public constant LOCKED_6M_DATE = START_DATE + 3 minutes;
    uint public constant LOCKED_8M_DATE = START_DATE + 4 minutes;
    uint public constant LOCKED_12M_DATE = START_DATE + 5 minutes;

}