# Alpha Omega Staking

[![Solidity](https://img.shields.io/badge/Solidity-0.8-363636?logo=solidity)](https://soliditylang.org/)
[![Ethereum](https://img.shields.io/badge/Ethereum-EVM-3C3C3D?logo=ethereum)](https://ethereum.org/)

A decentralized staking farm protocol in Solidity featuring Alpha token (APH) deposits, Omega token (OMG) reward distribution, and time-based yield farming mechanics. Users stake APH tokens and earn OMG rewards through a transparent, on-chain reward distribution system.

## Features

- **Token staking** — deposit Alpha (APH) tokens into the staking farm
- **Reward distribution** — earn Omega (OMG) tokens as staking rewards
- **Time-based yield** — reward calculation based on staking duration
- **Dual token system** — separate deposit and reward token contracts
- **Transparent mechanics** — all staking and reward logic on-chain
- **Deploy-ready** — Solidity 0.8 contracts compatible with any EVM network

## Tech Stack

- **Solidity ^0.8.0** — Smart contract language
- **Ethereum EVM** — Compatible with any EVM network

## Contracts

| Contract | File | Description |
|----------|------|-------------|
| AlphaToken | `AlphaToken.sol` | APH deposit token contract |
| OmegaToken | `OmegaToken.sol` | OMG reward token contract |
| TokenFarm | `TokenFarm.sol` | Staking farm with reward distribution |

---

Built with dedication by [Giovanni Romero](https://github.com/giovanniromero-dev)
