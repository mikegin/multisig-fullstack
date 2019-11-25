pragma solidity ^0.5.8;

contract MultiSig {
    address[] public addresses;
    mapping (address => bool) public canSend;
    
    
    modifier senderIsOwner() {
        bool isOwner;
        for(uint i = 0; i < addresses.length; i++) {
            if(addresses[i] == msg.sender) {
                isOwner = true;
            }
        }
        require(isOwner, "Not owner.");
        _;
    }
    
    constructor (address[] memory _addresses) public payable {
        addresses = _addresses;
    }
    
    function allowSending () public senderIsOwner {
        
        
        canSend[msg.sender] = true;
    }
    
    function send (address payable destination, uint value) public senderIsOwner{
        for(uint i = 0; i < addresses.length; i++) {
            require(canSend[addresses[i]] == true, "Permission to send not given.");
        }
        
        destination.transfer(value);
        
        //reset
        for(uint i = 0; i < addresses.length; i++) {
            canSend[addresses[i]] = false;
        }
    }
    
    function() external payable {
    
    }
    
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}
