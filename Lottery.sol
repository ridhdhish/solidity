// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract Lotttery {
    address public owner;
    address payable[] public players;
    uint public lotteryId;
    mapping (uint => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
        lotteryId = 1;
    }

    // Enroll player
    function enter() public payable {
        // To Enroll invest atleast 0.01 ether
        require(msg.value > .01 ether);

        // address of player entering lottery
        players.push(payable(msg.sender));
    }

    // Declare Winner
    function pickWinner() public onlyowner {
        uint index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);

        lotteryHistory[lotteryId] = players[index];
        lotteryId++;
        
        // reset all players
        players = new address payable[](0);
    }

    // Get Random number
    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    modifier onlyowner() {
        require(msg.sender == owner, "Only Owner has authority to Pick Winner");
        _;
    }
}