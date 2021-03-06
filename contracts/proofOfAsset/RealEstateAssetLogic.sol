pragma solidity ^0.4.15;

//import "./DhOraclizeBase.sol";
import "./SmartAssetLogicStorage.sol";

contract RealEstateAssetLogic {

    SmartAssetLogicStorage assetLogicStorage;

    function RealEstateAssetLogic() {
        
        assetLogicStorage = new SmartAssetLogicStorage();

    }

    function updateAvailability(bool availability) internal {
        assetLogicStorage.setSmartAssetAvailabilityData(availability);
    }

    function initialRealEstateData(uint256 nrOfIdenticalEstates, uint timestamp, uint256 year, bytes32 docUrl, bytes32 propertyType, bytes32 email, uint256 governmentNumber, bytes32 _address, bytes32 _empty, uint256 sqm, bytes32 state, bytes32 assetType) private returns(bool) {
    
        assetLogicStorage.setSmartAssetData(
        nrOfIdenticalEstates,
        sha256(
        nrOfIdenticalEstates,
        timestamp, 
        year, 
        docUrl, 
        propertyType, 
        email, 
        governmentNumber, 
        _address, 
        _empty, 
        sqm, 
        state, 
        assetType)
        );

        return true;

    }

    function getSmartAssetPrice() constant returns (uint256) {

        return assetLogicStorage.getSmartAssetPrice();
      
    } 

 /*   function isAssetTheSameState() onlySmartAssetRouter constant returns (bool) {
        var(nrCars, timestamp, year, docUrl, smoker, email, model, vin, color, millage, state, owner, assetType) = getById();
        return checkState(nrCars, timestamp, docUrl, smoker, email, model, vin, color, millage);
    } 

    function checkState(uint256 nrEstates, uint timestamp, uint256 year, bytes32 docUrl, bytes32 propertyType, bytes32 email, uint256 governmentNumber, bytes32 _address, bytes32 _empty, uint256 sqm, bytes32 state, bytes32 assetType) private returns(bool) {
        
        var hash = assetLogicStorage.getSmartAssetData();

        return sha256(
        nrEstates,
        timestamp, 
        year, 
        docUrl, 
        propertyType, 
        email, 
        governmentNumber, 
        _address, 
        _empty, 
        sqm, 
        state, 
        assetType
        ) == hash;

    } */

    function getSmartAssetAvailability() constant returns (bool availability) {
        return assetLogicStorage.getSmartAssetAvailability();
    }

    /**
     * @dev Max function
     */
    function max(uint a, uint b) private returns (uint) {
        return a > b ? a : b;
    }
}
