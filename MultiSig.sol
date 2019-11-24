// pragma solidity 0.5.8;

// contract Structs {
//     struct VotingInfo {
//         address person;
//         uint256 blockNumber;
//         bool hasVoted;
//     }
//     VotingInfo temp;
//     event PersonVoted(address person, uint256 blockNumber, bool hasVoted);
//     mapping (address => VotingInfo) public voter;
    
//     function vote(address person) public {
//         emit PersonVoted(voter[msg.sender].person, voter[msg.sender].blockNumber, voter[msg.sender].hasVoted);
        
//         voter[msg.sender].person = person;
//         voter[msg.sender].blockNumber = block.number;
//         voter[msg.sender].hasVoted = true;
        
//         emit PersonVoted(voter[msg.sender].person, voter[msg.sender].blockNumber, voter[msg.sender].hasVoted);
//     }
// }

pragma solidity ^0.5.8;

contract MultiSig {
    address one;
    address two;
    
    mapping (address => bool) canSend;
    
    constructor (address _one, address _two) public payable {
        one = _one;
        two = _two;
    }
    
    function allowSending () public payable{
        require(msg.sender == one || msg.sender == two);
        
        canSend[msg.sender] = true;
    }
    
    function send (address payable destination, uint value) public {
        require(msg.sender == one || msg.sender == two, "Not allowed");
        require(canSend[one] == true && canSend[two] == true, "Can't send");
        
        destination.transfer(value);
        
        //reset
        canSend[one] = false;
        canSend[two] = false;
    }
    
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}

