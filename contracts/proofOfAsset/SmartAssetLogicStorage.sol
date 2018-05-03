pragma solidity ^0.4.15;

import 'contracts/zeppelin/Destructible.sol';

contract SmartAssetLogicStorage is Destructible {

    address assetLogic;

    struct SmartAssetPriceData {
        uint price;
        uint256 identicalAssets;
        bool availability;
        bytes32 hash;
    }

    SmartAssetPriceData smartAssetPriceData;

    modifier onlyCarAssetLogic() {
        require(msg.sender == assetLogic);
        _;
    }

    function CarAssetLogicStorage() public {

        assetLogic = msg.sender;

    }

    function setAssetPrice(uint256 _newPrice) public onlyCarAssetLogic {

        smartAssetPriceData.price = _newPrice;

    }

    function deleteAsset() public onlyCarAssetLogic {
        delete smartAssetPriceData;
    }

    function setSmartAssetData(uint256 identicalCars, bytes32 hash) public onlyCarAssetLogic {
        smartAssetPriceData = SmartAssetPriceData(smartAssetPriceData.price, identicalCars, true, hash);
    }

    function getSmartAssetData() public constant returns (uint, bytes32) {
        return (smartAssetPriceData.identicalAssets, smartAssetPriceData.hash);
    }

    function setSmartAssetAvailabilityData(bool availability) onlyCarAssetLogic {
        smartAssetPriceData.availability = availability;
    }

    function getSmartAssetAvailability() public constant returns(bool) {
        return smartAssetPriceData.availability;
    }

    function setCarAssetLogic(address _newAssetLogic) onlyOwner {
        assetLogic = _newAssetLogic;
    }

    function getSmartAssetPrice() public constant returns (uint256) {

        return smartAssetPriceData.price;

    }


}
