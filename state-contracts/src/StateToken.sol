// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// The Ownable contract from OpenZeppelin is used exclusively to manage ownership during deployment.
// Ownership enables the deployer to perform initial setup tasks and then renounce ownership immediately after.
// This ensures that no centralized control remains, increasing user trust and decentralization.
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title STATE Token V2.1 with Ratio-Based Initial Supply Allocation
/// @author System State Protocol
/// @notice ERC20 token with 5/95 minting distribution between two addresses at deployment
/// @dev Uses OpenZeppelin ERC20 and Ownable contracts

//-------------------------------Token name clarification----------------------------------
//NOTE: Mainnet token name is pSTATE

contract STATE_V2_2 is ERC20, Ownable(msg.sender) {
    /// @notice Maximum total supply of the token (1 quadrillion tokens, 18 decimals)
    event InitialAllocation(
        address indexed fivePercentRecipient,
        address indexed ninetyFivePercentRecipient,
        uint256 fivePercentAmount,
        uint256 ninetyFivePercentAmount
    );
    uint256 public constant FIVE_PERCENT_ALLOCATION = 50000000000000 ether; // 5% of total supply (50 trillion tokens)
    /// @notice 95% of total supply (950 trillion tokens)
    uint256 public constant NINETY_FIVE_PERCENT_ALLOCATION =
        950000000000000 ether;
    /// @param tokenName The name of the token
    /// @param tokenSymbol The symbol of the token
    /// @param recipientFivePercent Address receiving 5% of total supply
    /// @param recipientNinetyFivePercent Address receiving 95% of total supply
    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        address recipientFivePercent,
        address recipientNinetyFivePercent
    ) ERC20(tokenName, tokenSymbol) {
        require(recipientFivePercent != address(0), "Invalid 5% address");
        require(
            recipientFivePercent != recipientNinetyFivePercent,
            "Recipients must be different"
        );
        require(
            recipientNinetyFivePercent != address(0),
            "Invalid 95% address"
        );

        _mint(recipientFivePercent, FIVE_PERCENT_ALLOCATION);
        _mint(recipientNinetyFivePercent, NINETY_FIVE_PERCENT_ALLOCATION);
        emit InitialAllocation(
            recipientFivePercent,
            recipientNinetyFivePercent,
            FIVE_PERCENT_ALLOCATION,
            NINETY_FIVE_PERCENT_ALLOCATION
        );
    }
}
