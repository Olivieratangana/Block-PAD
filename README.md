# Block-PAD CBDC Framework

Notebooks and code for the **Block-PAD framework**, a blockchain-enabled architecture for **resilient and privacy-preserving CBDC transactions**.  
This repository provides the experimental implementation used in the paper:

> **O. Atangana, L. Khoukhi, M. Barbier, J. Di Manno.**  
> *Block-PAD: A Blockchain-enabled Framework for Resilient and Flexible CBDC Transactions Leveraging Digital Identity.*  
> (Submitted, 2025).

---

## 📌 Overview

The notebooks included in this repository correspond to different components of the Block-PAD architecture.  
Each notebook highlights a specific functionality or set of experiments. While there is no strict execution order, the development followed the same structure as the paper:

1. **Identity Management** – Digital identity onboarding and verification.  
2. **Withdrawal** – Secure withdrawal and funding/defunding mechanisms.  
3. **Offline Transactions (Alice → Bob)** – Full offline transaction between two parties.  
4. **Hybrid Transactions (Bob → Carla)** – Staged offline transaction requiring online reconciliation.  
5. **Deposit** – Secure deposit and reconciliation to pseudonymous accounts.  
6. **Metrics and Performance** – Experimental evaluation (latency, throughput, onboarding/verification times).
7. **Smart Contracts** – On-chain components (`PADLedger.sol`, `ShardLedger.sol`) supporting decentralized recording and balance updates.
---

## 📂 Repository Structure



├── cbdc_id_revision.ipynb          # Identity onboarding & verification

├── cbdc_blockpad.ipynb             # Blocpad operations simulator

├── PADLedger.sol                   # Ethereum smart contract for PADLedger

├── ShardLedger.sol                 # Ethereum smart contract for PADLedger

├── ShardLedger_ABI.Json            #  JSON File for Shard Ledger

├── PADLedger_ABI.Json              #  JSON File for PAD Ledger

 
---

## ⚙️ Installation

Clone the repository:

bash
git clone https://github.com/<your-username>/blockpad-cbdc.git
cd blockpad-cbdc

Typical dependencies include:

numpy

pandas

matplotlib

scikit-learn

jupyter

▶️ Usage

Launch Jupyter Notebook:

jupyter notebook


Open any of the notebooks (e.g., cbdc_id_revision.ipynb) and run the cells to reproduce the experiments.

Each notebook is self-contained and corresponds to one part of the framework (identity, withdrawal, transactions, deposit, metrics).

## 🔗 Smart Contracts
PADLedger.sol

## PADLedger Smart Contract

The `PADLedger` smart contract acts as a **decentralized ledger** to record and manage transactions in the Payment Authorization & Decryption (PAD) system.  
It provides functionalities for securely storing transaction records and simulating account balance updates.

### Key Features

- **Transaction Recording**  
  Each transaction is stored on-chain with details such as:
  - `transactionId` – unique identifier for the transaction  
  - `from` – sender’s address  
  - `to` – recipient’s address  
  - `amount` – transaction amount  
  - `timestamp` – block timestamp of the transaction  
  - `txType` – type of transaction (e.g., `deposit`, `pip_request`)  
  - `details` – additional metadata (e.g., `phi`, token value)  

- **Event Emission**  
  The contract emits a `TransactionPosted` event whenever a new transaction is recorded, enabling off-chain systems to listen and react to ledger updates.

- **Balance Management**  
  The ledger simulates balance operations using the `updateBalance` function:  
  - `INC` → Increments a user’s balance  
  - `DEC` → Decrements a user’s balance (with safety checks for insufficient funds)  
  - Rejects any unrecognized operations

### Example Usage

- Posting a new transaction:  
  ```solidity
  postTransaction(1, msg.sender, recipient, 100, "deposit", "Initial funding");

### Applications

The PADLedger is designed as the core ledger layer in the simulator, ensuring that every PAD-related transaction is:

Recorded immutably on-chain for auditability.

Linked with metadata (e.g., cryptographic proof parameters).

Used to track balances across pseudonymous participants.

This contract provides a simple yet extensible basis for exploring decentralized transaction logging in CBDC simulation scenarios.

ShardLedger.sol

# ShardLedger — Functional Explanation

## Purpose
`ShardLedger` is a simplified Ethereum smart contract that maintains, for each address, an **encrypted balance** and exposes a function to **update** this balance either additively (increment) or subtractively (decrement).  
It acts as a “mini encrypted ledger” for CBDC/PAD-style scenarios where transaction amounts should not be visible in plaintext on-chain.

## Data Model
- `MAXB`: maximum allowed balance (in plaintext) beyond which the decrypted value cannot go.  
- `t`, `q`: system parameters used to **simulate decryption** (e.g., scaling factor and large prime).  
- `mapping(address => uint256) encryptedBalances`: table of **encrypted balances** associated with each address.  

> Note: “encrypted” here is conceptual. The contract does not implement real homomorphic encryption; it manipulates `uint256` values that **represent** ciphertexts according to your off-chain/POC scheme.

## Events
- `BalanceUpdated(address user, uint256 newEncryptedBalance)`: emitted after each successful balance update.

## Main Functions

### `updateBalance(uint256 c_B, uint256 c_T, string op) → uint256`
Updates the encrypted balance of `msg.sender`.

- **Inputs**
  - `c_B`: current encrypted balance (provided by the caller).  
  - `c_T`: encrypted token/amount to apply.  
  - `op`: `"INC"` for increment, `"DEC"` for decrement.  

- **Logic**
  - **INC**: computes `newBalance = c_B + c_T`, then calls `dec(newBalance, 1)` to **simulate decryption** and checks whether the result exceeds `MAXB`. If it does → revert.  
  - **DEC**: computes `newBalance = c_B + (q - c_T)` (modular subtraction).  
  - Stores `encryptedBalances[msg.sender] = newBalance` and emits the update event.  

- **Returns**
  - The new encrypted balance.

### `dec(uint256 c, uint256 R_pvk) → uint256 (view)`
  

📊 Results & Reproducibility

The notebooks reproduce the main experimental results reported in the paper:

Latency: ~40–47 ms per transaction

Throughput: ~23.6 TPS in full offline mode

Onboarding time: microsecond scale

Verification time: negligible, near-zero

Figures generated from the notebooks (e.g., onboarding and verification metrics) are included in the repository for reference.

📖 Citation

If you use this code, please cite our paper:

@article{atangana2025blockpad,
  author    = {O. Atangana and L. Khoukhi and M. Barbier and J. Di Manno},
  title     = {Block-PAD: A Blockchain-enabled Framework for Resilient and Flexible CBDC Transactions Leveraging Digital Identity},
  journal   = {Submitted to Computer Networks},
  year      = {2025}
}

📜 License

This project is released under the MIT License. You are free to use, modify, and distribute it with attribution.


