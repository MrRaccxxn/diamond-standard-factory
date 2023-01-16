// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import {Diamond} from "./Diamond.sol";

contract DiamondFactory is Ownable {
    uint256 eventsCounter;
    address diamondCutAddress;

    constructor(address _diamondCutAddress) {
        eventsCounter = 0;
        diamondCutAddress = _diamondCutAddress;
    }

    mapping(uint256 => eventInfo) events;

    struct eventInfo {
        uint256 eventId;
        address owner;
        string eventName;
        address eventAddress;
    }

    event newEventCreated(uint256 eventId, address owner, string eventName, address eventAddress);

    function setDiamondCutAddress(address newDiamondCutAddress) public onlyOwner {
        diamondCutAddress = newDiamondCutAddress;
    }

    function getDiamondCutAddress() public view onlyOwner returns (address) {
        return diamondCutAddress;
    }

    function createNewEvent(string memory eventName, address eventOwner) public onlyOwner returns (address) {
        address eventAddress = address(new Diamond(eventOwner, diamondCutAddress));
        eventInfo storage _eventInfo = events[eventsCounter];
        _eventInfo.eventId = eventsCounter;
        _eventInfo.owner = eventOwner;
        _eventInfo.eventName = eventName;
        _eventInfo.eventAddress = eventAddress;

        emit newEventCreated(eventsCounter, eventOwner, eventName, eventAddress);
        eventsCounter++;

        return eventAddress;
    }

    function getEventById(uint256 eventId)
        public
        view
        returns (
            uint256,
            address,
            string memory,
            address
        )
    {
        require(eventId >= 0 && eventId < eventsCounter, "Please submit a valid Event Id");
        eventInfo storage _eventInfo = events[eventId];
        return (_eventInfo.eventId, _eventInfo.owner, _eventInfo.eventName, _eventInfo.eventAddress);
    }
}
