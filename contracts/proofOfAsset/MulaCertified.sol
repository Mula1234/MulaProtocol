pragma solidity ^0.4.15;

import 'contracts/zeppelin/Destructible.sol';
import './MulaCertifiedStorage.sol';


contract MulaCertified is Destructible {

    MulaCertifiedStorage mulaCertifiedStorage;

    function certify(address _address) onlyOwner() {
        //some other logic  if else
        mulaCertifiedStorage.addCertified(_address);
    }

    function unCertify(address _address) onlyOwner() {
        mulaCertifiedStorage.removeCertified(_address);
    }

    function isCertified(address _address) constant returns(bool) {
        return mulaCertifiedStorage.isCertified(_address);
    }

    function setStorageAddress(address _mulaCertifiedStorage) onlyOwner {
        mulaCertifiedStorage = MulaCertifiedStorage(_mulaCertifiedStorage);
    }

}
