// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PADLedger {
    // Structure representing a transaction recorded on the ledger
    struct Transaction {
        uint256 transactionId;
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
        string txType;   // "deposit", "pip_request", etc.
        string details;  // Additional information (e.g., phi, token, etc.)
    }

    Transaction[] public transactions;

    event TransactionPosted(
        uint256 transactionId,
        address from,
        address to,
        uint256 amount,
        string txType,
        uint256 timestamp
    );

    // Function to post a transaction on the ledger
    function postTransaction(
        uint256 transactionId,
        address from,
        address to,
        uint256 amount,
        string memory txType,
        string memory details
    ) public {
        Transaction memory txData = Transaction({
            transactionId: transactionId,
            from: from,
            to: to,
            amount: amount,
            timestamp: block.timestamp,
            txType: txType,
            details: details
        });
        transactions.push(txData);
        emit TransactionPosted(transactionId, from, to, amount, txType, block.timestamp);
    }

    // Simulated balance update function
    mapping(address => uint256) public balances;

    function updateBalance(address user, uint256 amount, string memory op) public returns (bool) {
        // Simulate the INC or DEC operation (add or subtract)
        if (keccak256(abi.encodePacked(op)) == keccak256("INC")) {
            balances[user] += amount;
        } else if (keccak256(abi.encodePacked(op)) == keccak256("DEC")) {
            require(balances[user] >= amount, "Insufficient balance");
            balances[user] -= amount;
        } else {
            revert("Unrecognized operation");
        }
        return true;
    }
}
