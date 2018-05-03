pragma solidity ^0.4.15;

import 'contracts/zeppelin/Destructible.sol';

contract MulaCertifiedStorage is Destructible {

    address mulaCertifiedAddress;
    mapping(address => bool) private certified;

    modifier onlyMulaCertified() {
        require(msg.sender == mulaCertifiedAddress);
        _;
    }

    function addCertified(address _address) onlyMulaCertified {
        certified[_address] = true;
    }

    function removeCertified(address _address) onlyMulaCertified {
        delete certified[_address];
    }

    function isCertified(address _address) constant returns(bool) {
        return certified[_address];
    }

    function setMulaCertifiedAddress(address _mulaCertifiedAddress) onlyOwner {
        mulaCertifiedAddress = _mulaCertifiedAddress;
    }
}
