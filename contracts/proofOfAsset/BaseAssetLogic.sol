pragma solidity ^0.4.15;

import 'contracts/zeppelin//Destructible.sol';


/**
 * Interface for SmartAsset contract
 */
contract SmartAssetInterface {
    function getAssetById(uint24 id) constant
    returns (
        uint timestamp,
        uint8 year,
        bytes32 docUrl,
        uint8 _type,
        bytes32 email,
        bytes32 b1,
        bytes32 b2,
        bytes32 b3,
        uint u1,
        uint8 state,
        address owner,
        bytes32 assetType);

    function updateFromExternalSource(
        uint24 id,
        bytes11 latitude,
        bytes11 longitude,
        bytes32 imageUrl);

    function getAssetIotById(uint24 id) constant returns (bytes11, bytes11, bytes32, bytes32);
}


/**
 * @title Base smart asset logic contract
 */
contract BaseAssetLogic is Destructible {
    address smartAssetAddr;
    address smartAssetRouterAddr;

    /**
     * Check whether SmartAssetRouter contract executes method or not
     */
    modifier onlySmartAssetRouter {
        require(msg.sender == smartAssetRouterAddr);
        _;
    }

    function getById(uint24 assetId) returns (
        uint timestamp,
        uint8 year,
        bytes32 docUrl,
        uint8 _type,
        bytes32 email,
        bytes32 b1,
        bytes32 b2,
        bytes32 b3,
        uint u1,
        uint8 state,
        address owner,
        bytes32 assetType)
    {
        SmartAssetInterface asset = SmartAssetInterface(smartAssetAddr);
        return asset.getAssetById(assetId);
    }

    function onAssetSold(uint24 assetId) {

    }

    function calculateAssetPrice(uint24 assetId) returns (uint) {
    }

    function getSmartAssetPrice(uint24 assetId) constant returns (uint) {
        return 0;
    }

    function getSmartAssetAvailability(uint24 assetId) constant returns (bool) {
        return true;
    }

    function isAssetTheSameState(uint24 assetId) constant returns (bool sameState) {
        return true;
    }

    function forceUpdateFromExternalSource(uint24 id, string param) {
    }

    function setSmartAssetAddr(address contractAddress) onlyOwner returns (bool result) {
        if (contractAddress == address(0)) {
            throw;
        } else {
            smartAssetAddr = contractAddress;
            return true;
        }
    }

    function setSmartAssetRouterAddr(address contractAddress) onlyOwner returns (bool result) {
        if (contractAddress == address(0)) {
            throw;
        } else {
            smartAssetRouterAddr = contractAddress;
            return true;
        }
    }
}
