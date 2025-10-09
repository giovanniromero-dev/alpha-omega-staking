// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./AlphaToken.sol";
import "./OmegaToken.sol";

contract TokenFarm {

    // Declaraciones iniciales
    string public name = "Omega Token Farm";
    address public owner;
    AlphaToken public alphaToken;
    OmegaToken public omegaToken;

    // Estructuras de datos
    address [] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    // Constructor
    constructor(AlphaToken _alphaToken, OmegaToken _omegaToken) {
        alphaToken = _alphaToken;
        omegaToken = _omegaToken;
        owner = msg.sender;
    }

    // Stake de tokens
    function stakeTokens(uint _amount) public {
        // Se requiere una cantidad superior a 0
        require(_amount > 0, "La cantidad no puede ser menor a 0");
        // Transferir tokens Alpha al Smart Contract principal
        alphaToken.transferFrom(msg.sender, address(this), _amount);
        // Actualizar el saldo del staking
        stakingBalance[msg.sender] += _amount;
        // Guardar el staker
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }
        // Actualizamos el estado del staking
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Quitar el staking de los tokens
    function unstakeTokens() public {
        // Saldo del staking de un usuario
        uint balance = stakingBalance[msg.sender];
        // Se requiere una cantidad superior a 0
        require(balance > 0, "El balance del staking es 0");
        // Transferencia de los tokens al usuario
        alphaToken.transfer(msg.sender, balance);
        // Resetea el balance de staking del usuario
        stakingBalance[msg.sender] = 0;
        // Actualizar el estado del staking 
        isStaking[msg.sender] = false;
    }

    // Emision de Tokens (recompesas)
    function issueTokens() public {
        // Unicamente ejecutable por el owner
        require(msg.sender == owner, "No eres el owner");
        // Emitir tokens a todos los stakers
        for(uint i=0; i < stakers.length; i++){
            uint balance = stakingBalance[stakers[i]];
            if(balance > 0){
                omegaToken.transfer(stakers[i], balance);
            }
        }
    }   
}
