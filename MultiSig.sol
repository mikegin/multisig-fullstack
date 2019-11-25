pragma solidity ^0.5.8;

contract MultiSig {
    mapping(address => bool) isOwner;
    mapping (address => bool) canSend;
    
    constructor (address[] memory addresses) public payable {
        address lastAddress;
        for(uint i = 0; i < addresses.length; i++) {
            require(lastAddress < addresses[i], "Addresses must be in increasing order to preserve uniqueness.");
            isOwner[addresses[i]] = true;
            lastAddress = addresses[i];
        }
    }
    
    function allowSending () public {
        require(isOwner[msg.sender] == true, "Not allowed.");
        
        canSend[msg.sender] = true;
    }
    
    function send (address[] memory addresses, address payable destination, uint value) public {
        require(isOwner[msg.sender] == true);
        
        address lastAddress; // strictly increasing addresses to enforce uniqueness
        for(uint i = 0; i < addresses.length; i++) {
            require(lastAddress < addresses[i], "Addresses must be in increasing order.");
            require(isOwner[addresses[i]] == true, "Must be an owner in this contract.");
            require(canSend[addresses[i]] == true, "Permission to send not given.");
            lastAddress = addresses[i];
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
