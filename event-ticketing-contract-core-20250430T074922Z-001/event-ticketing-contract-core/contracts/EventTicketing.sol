// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract EventTicketing is ERC721URIStorage {
    uint256 public ticketId;
    address public owner;

    mapping(uint256 => uint256) public ticketPrice;

    constructor() ERC721("EventTicket", "ETKT") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function mintTicket(address to, uint256 price, string memory uri) external onlyOwner {
        uint256 newTicketId = ticketId++;
        _mint(to, newTicketId);
        _setTokenURI(newTicketId, uri);
        ticketPrice[newTicketId] = price;
    }

    function buyTicket(uint256 ticketId) external payable {
        uint256 price = ticketPrice[ticketId];
        require(msg.value == price, "Incorrect payment");

        address ticketOwner = ownerOf(ticketId);
        _transfer(ticketOwner, msg.sender, ticketId);
        payable(ticketOwner).transfer(price);
    }
}
