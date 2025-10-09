// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract OmegaToken {
    
    // Declarations
    string public name = "Omega Token";
    string public symbol = "OMG";
    uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
    uint8 public decimals = 18;

    // Event emitted when tokens are transferred between users
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    // Event emitted when an operator is approved
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 value
    );

    // Data structures
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    // Constructor
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // Transfer tokens from sender to another address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // Approve a certain amount for another address (spender)
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Transfer tokens on behalf of another address
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from], "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Allowance exceeded");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
