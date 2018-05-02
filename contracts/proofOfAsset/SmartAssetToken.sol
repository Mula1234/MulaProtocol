pragma solidity ^0.4.11;

import "zeppelin-solidity/contracts/token/StandardToken.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract SmartAssetToken is StandardToken {
    using SafeMath for uint256;
    address smartAssetStorage;
    address owner;
    string public name = "BankEx Smart Asset Token [ID = ";
    string public constant symbol = "BKXAT";
    uint8 public constant decimals = 2;


    uint256 private constant multiplier = 10 ** uint256(decimals);

    uint256 public constant totalSupply = 1 * multiplier;

    modifier onlySmartAssetStorage {
        require(msg.sender == smartAssetStorage);
        _;
    }

    struct SmartAssetDataManual {
    uint8 year;
    uint8 _type;
    bytes32 docUrl;
    bytes32 email;
    bytes32 b1;
    bytes32 b2;
    bytes32 b3;
    uint u1;
    }

    struct SmartAssetDataIot {
    bytes11 latitude;
    bytes11 longitude;
    bytes32 imageUrl;
    }

    SmartAssetDataManual smartAssetManual;
    SmartAssetDataIot smartAssetIot;

    function SmartAssetToken(
    uint24 id,
    address tokenOwner,
    uint8 year,
    uint8 _type,
    bytes32 docUrl,
    bytes32 email,
    bytes32 b1,
    bytes32 b2,
    bytes32 b3,
    uint u1) {
        require(tokenOwner != address(0));

        smartAssetManual = SmartAssetDataManual(
        year,
        _type,
        docUrl,
        email,
        b1,
        b2,
        b3,
        u1
        );

        balances[owner] = totalSupply;
        smartAssetStorage = msg.sender;
        owner = tokenOwner;
        name = strConcat(name, uint2str(id), ']');
    }

    function setSmartAssetDataIot(
    bytes11 latitude,
    bytes11 longitude,
    bytes32 imageUrl) onlySmartAssetStorage
    {
        smartAssetIot = SmartAssetDataIot(latitude, longitude, imageUrl);
    }

    function transferAssetOwner(address _to) public  onlySmartAssetStorage {
        balances[owner] = 0;
        balances[_to] = totalSupply;
        Transfer(owner, _to, totalSupply);
        owner = _to;
    }

    function transfer(address _to, uint256 _value) public  onlySmartAssetStorage returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public onlySmartAssetStorage returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public onlySmartAssetStorage returns (bool) {
        return super.approve(_spender, _value);
    }

    function allowance(address _owner, address _spender) public onlySmartAssetStorage constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function uint2str(uint i) internal returns (string){
        if (i == 0) return "0";
        uint j = i;
        uint len;
        while (j != 0){
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        return string(bstr);
    }

    function strConcat(string _a, string _b, string _c) internal returns (string) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        string memory abc = new string(_ba.length + _bb.length + _bc.length);
        bytes memory babc = bytes(abc);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babc[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babc[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babc[k++] = _bc[i];
        return string(babc);
    }

    function getSmartAssetDataManual() constant returns(uint8, bytes32, uint8, bytes32, bytes32, bytes32, bytes32, uint) {
        return(smartAssetManual.year, smartAssetManual.docUrl, smartAssetManual._type, smartAssetManual.email, smartAssetManual.b1, smartAssetManual.b2, smartAssetManual.b3, smartAssetManual.u1);
    }

    function getSmartAssetDataIot() constant returns (bytes11, bytes11, bytes32) {
        return (smartAssetIot.latitude, smartAssetIot.longitude, smartAssetIot.imageUrl);
    }

    function getSmartAssetYear() constant returns(uint8) {
        return smartAssetManual.year;
    }

    function getSmartAssetDocURl() constant returns(bytes32) {
        return smartAssetManual.docUrl;
    }

    function getSmartAssetType() constant returns(uint8) {
        return smartAssetManual._type;
    }

    function getSmartAssetEmail() constant returns(bytes32) {
        return smartAssetManual.email;
    }

    function getSmartAssetb1() constant returns(bytes32) {
        return smartAssetManual.b1;
    }

    function getSmartAssetb2() constant returns(bytes32) {
        return smartAssetManual.b2;
    }

    function getSmartAssetb3() constant returns(bytes32) {
        return smartAssetManual.b3;
    }

    function getSmartAssetu1() constant returns(uint) {
        return smartAssetManual.u1;
    }
}
