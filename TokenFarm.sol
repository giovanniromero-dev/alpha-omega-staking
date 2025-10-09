// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./AlphaToken.sol";
import "./OmegaToken.sol";

contract TokenFarm {

    // Initial declarations
    string public name = "Omega Token Farm";
    address public owner;
    AlphaToken public alphaToken;
    OmegaToken public omegaToken;

    // Data structures
    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // Constructor
    constructor(AlphaToken _alphaToken, OmegaToken _omegaToken) {
        alphaToken = _alphaToken;
        omegaToken = _omegaToken;
        owner = msg.sender;
    }

    // Stake tokens
    function stakeTokens(uint _amount) public {
        // Require a valid amount greater than 0
        require(_amount > 0, "Amount must be greater than 0");
        // Transfer Alpha Tokens from the user to this smart contract
        alphaToken.transferFrom(msg.sender, address(this), _amount);
        // Update staking balance
        stakingBalance[msg.sender] += _amount;
        // Add the staker to the array if it's their first time staking
        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }
        // Update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Unstake tokens
    function unstakeTokens() public {
        // Retrieve the staking balance for the user
        uint balance = stakingBalance[msg.sender];
        // Require that the staking balance is greater than 0
        require(balance > 0, "Staking balance is 0");
        // Transfer tokens back to the user
        alphaToken.transfer(msg.sender, balance);
        // Reset staking balance for the user
        stakingBalance[msg.sender] = 0;
        // Update staking status
        isStaking[msg.sender] = false;
    }

    // Issue reward tokens
    function issueTokens() public {
        // Only the owner can call this function
        require(msg.sender == owner, "Caller must be the owner");
        // Loop through all stakers and issue reward tokens
        for (uint i = 0; i < stakers.length; i++) {
            uint balance = stakingBalance[stakers[i]];
            if (balance > 0) {
                omegaToken.transfer(stakers[i], balance);
            }
        }
    }
}
