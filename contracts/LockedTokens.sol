pragma solidity ^0.4.11;

// ----------------------------------------------------------------------------
// HAZ 'HazzaNetwork Token' contract - ERC20 Token Interface
//
// Refer to http://hazza.network for further information.
//
// Enjoy. (c) ANX International and BokkyPooBah / Bok Consulting Pty Ltd 2017.
// The MIT Licence.
// ----------------------------------------------------------------------------

import "./ERC20Interface.sol";
import "./SafeMath.sol";
import "./HazzaNetworkTokenConfig.sol";


// ----------------------------------------------------------------------------
// Contract that holds the locked token information
// ----------------------------------------------------------------------------
contract LockedTokens is HazzaNetworkTokenConfig {
    using SafeMath for uint;

    // ------------------------------------------------------------------------
    // locked totals
    // tokens
    // ------------------------------------------------------------------------
    uint public constant TOKENS_LOCKED_6M_TOTAL = 14000000 * DECIMALSFACTOR;
    uint public constant TOKENS_LOCKED_8M_TOTAL = 26000000 * DECIMALSFACTOR;
    uint public constant TOKENS_LOCKED_12M_TOTAL = 26000000 * DECIMALSFACTOR;
    
    // ------------------------------------------------------------------------
    // Current totalSupply of locked tokens
    // ------------------------------------------------------------------------
    uint public totalSupplyLocked6M;
    uint public totalSupplyLocked8M;
    uint public totalSupplyLocked12M;

    // ------------------------------------------------------------------------
    // Locked tokens mapping
    // ------------------------------------------------------------------------
    mapping (address => uint) public balancesLocked6M;
    mapping (address => uint) public balancesLocked8M;
    mapping (address => uint) public balancesLocked12M;

    // ------------------------------------------------------------------------
    // Address of Hazza Network token contract
    // ------------------------------------------------------------------------
    ERC20Interface public tokenContract;
    address public tokenContractAddress;


    // ------------------------------------------------------------------------
    // Constructor - called by token contract
    // ------------------------------------------------------------------------
    function LockedTokens(address _tokenContract) {
        tokenContract = ERC20Interface(_tokenContract);
        tokenContractAddress = _tokenContract;

        // any locked token balances known in advance of contract deployment can be added here
        // add6M(0xaBBa43E7594E3B76afB157989e93c6621497FD4b, 2000000 * DECIMALSFACTOR);
        // add8M(0xAddA9B762A00FF12711113bfDc36958B73d7F915, 2000000 * DECIMALSFACTOR);
        // add12M(0xAddA9B762A00FF12711113bfDc36958B73d7F915, 2000000 * DECIMALSFACTOR);

    }

    // ------------------------------------------------------------------------
    // Modifier to mark that a function can only be executed by the owner
    // ------------------------------------------------------------------------
    modifier onlyTokenContract {
        require(msg.sender == tokenContractAddress);
        _;
    }

    // ------------------------------------------------------------------------
    // Add to 6m locked balances and totalSupply
    // ------------------------------------------------------------------------
    function add6M(address account, uint value) onlyTokenContract {
        balancesLocked6M[account] = balancesLocked6M[account].add(value);
        totalSupplyLocked6M = totalSupplyLocked6M.add(value);
        assert(totalSupplyLocked6M <= TOKENS_LOCKED_6M_TOTAL);
    }


    // ------------------------------------------------------------------------
    // Add to 8m locked balances and totalSupply
    // ------------------------------------------------------------------------
    function add8M(address account, uint value) onlyTokenContract {
        balancesLocked8M[account] = balancesLocked8M[account].add(value);
        totalSupplyLocked8M = totalSupplyLocked8M.add(value);
        assert(totalSupplyLocked8M <= TOKENS_LOCKED_8M_TOTAL);
    }

    // ------------------------------------------------------------------------
    // Add to 8m locked balances and totalSupply
    // ------------------------------------------------------------------------
    function add12M(address account, uint value) onlyTokenContract {
        balancesLocked12M[account] = balancesLocked12M[account].add(value);
        totalSupplyLocked12M = totalSupplyLocked12M.add(value);
        assert(totalSupplyLocked12M <= TOKENS_LOCKED_12M_TOTAL);
    }

    // ------------------------------------------------------------------------
    // 6m locked balances for an account
    // ------------------------------------------------------------------------
    function balanceOfLocked6M(address account) constant returns (uint balance) {
        return balancesLocked6M[account];
    }


    // ------------------------------------------------------------------------
    // 8m locked balances for an account
    // ------------------------------------------------------------------------
    function balanceOfLocked8M(address account) constant returns (uint balance) {
        return balancesLocked8M[account];
    }

    // ------------------------------------------------------------------------
    // 12m locked balances for an account
    // ------------------------------------------------------------------------
    function balanceOfLocked12M(address account) constant returns (uint balance) {
        return balancesLocked12M[account];
    }


    // ------------------------------------------------------------------------
    // locked balances for an account
    // ------------------------------------------------------------------------
    function balanceOfLocked(address account) constant returns (uint balance) {
        return balancesLocked6M[account].add(balancesLocked8M[account]).add(balancesLocked12M[account]);
    }


    // ------------------------------------------------------------------------
    // locked total supply
    // ------------------------------------------------------------------------
    function totalSupplyLocked() constant returns (uint) {
        return totalSupplyLocked6M + totalSupplyLocked8M + totalSupplyLocked12M;
    }

    // ------------------------------------------------------------------------
    // validate totals of locked tokens
    // ------------------------------------------------------------------------
    function validateTotals() returns (bool) {
        if (
            totalSupplyLocked6M == TOKENS_LOCKED_6M_TOTAL
            && totalSupplyLocked8M == TOKENS_LOCKED_8M_TOTAL
            && totalSupplyLocked12M == TOKENS_LOCKED_12M_TOTAL
        ) {
            return true;
        } else {
            return false;
        }
    }

    // ------------------------------------------------------------------------
    // An account can unlock their 6m locked tokens 6m after token launch date
    // ------------------------------------------------------------------------
    function unlock6M() {
        require(now >= LOCKED_6M_DATE);
        uint amount = balancesLocked6M[msg.sender];
        require(amount > 0);
        balancesLocked6M[msg.sender] = 0;
        totalSupplyLocked6M = totalSupplyLocked6M.sub(amount);
        require(tokenContract.transfer(msg.sender, amount));
    }


    // ------------------------------------------------------------------------
    // An account can unlock their 8m locked tokens 8m after token launch date
    // ------------------------------------------------------------------------
    function unlock8M() {
        require(now >= LOCKED_8M_DATE);
        uint amount = balancesLocked8M[msg.sender];
        require(amount > 0);
        balancesLocked8M[msg.sender] = 0;
        totalSupplyLocked8M = totalSupplyLocked8M.sub(amount);
        require(tokenContract.transfer(msg.sender, amount));
    }

    // ------------------------------------------------------------------------
    // An account can unlock their 12m locked tokens 12m after token launch date
    // ------------------------------------------------------------------------
    function unlock12M() {
        require(now >= LOCKED_12M_DATE);
        uint amount = balancesLocked12M[msg.sender];
        require(amount > 0);
        balancesLocked12M[msg.sender] = 0;
        totalSupplyLocked12M = totalSupplyLocked12M.sub(amount);
        require(tokenContract.transfer(msg.sender, amount));
    }    
}