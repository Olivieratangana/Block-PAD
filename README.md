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

---

## 📂 Repository Structure



blockpad-cbdc/
│── cbdc_id_revision.ipynb # Identity onboarding & verification
│── cbdc_sim_paddecrfunding_defunding.ipynb # Withdrawal, funding & defunding
│── cbdc_sim_paddecryption.ipynb # Transaction decryption experiments
│── cbdc_sim_PADdeposittest.ipynb # Deposit to pseudonymous accounts
│── cbdc_sim_padledger3.ipynb # Ledger logic (Alice → Bob)
│── cbdc_sim_shardledger.ipynb # Hybrid transactions (Bob → Carla)
│── cbdc_simid4(depositviaPAd).ipynb # Extended deposit experiments
│── onboarding_summary.csv # Example dataset of onboarding metrics
│── onboarding_metrics.png # Performance figure (metrics)
│── README.md # This file


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


