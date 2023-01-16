// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "erc721a-upgradeable/contracts/ERC721AUpgradeable.sol";

contract EventFacet is ERC721AUpgradeable {
    address owner;
    uint32 private ticketsCounter;

    event newTicketMinted(uint32 fromTicket, uint32 quantity, address ticketOwner);

    function initialize(
        string memory _eventName,
        string memory _eventSymbol,
        address _owner
    ) public initializerERC721A {
        __ERC721A_init(_eventName, _eventSymbol);
        owner = _owner;
        ticketsCounter = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function mint(uint32 quantity) external payable {
        require(quantity > 0, "Quantity should be more than zero");
        _mint(msg.sender, quantity);
        emit newTicketMinted({fromTicket: ticketsCounter, quantity: quantity, ticketOwner: msg.sender});
        ticketsCounter += quantity;
    }
}
