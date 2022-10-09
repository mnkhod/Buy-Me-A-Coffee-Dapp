//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Switch this to your own contract address once deployed, for bookkeeping!
// Example Contract Address on Goerli: 0xDBa03676a2fBb6711CB652beF5B7416A53c1421D

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );
    
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    
    address payable owner;

    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    function buyLargeCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee for free!");
        require(msg.value == 0.003 ether,"can't buy large coffee!");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );

    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy coffee for free!");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function updateOwnerAddress(address newOwner) public {
      require(msg.sender == owner,"NOT OWNER");
      require(newOwner != address(0),"ADDRESS ZERO");
      owner = payable(newOwner);
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}
