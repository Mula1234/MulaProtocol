pragma solidity ^0.4.17;

//import "./DhOraclizeBase.sol";
import "./SmartAssetLogicStorage.sol";

contract CollectibleAssetLogic {

    SmartAssetLogicStorage assetLogicStorage;

    function CollectibleAssetLogic() {
        
        assetLogicStorage = new SmartAssetLogicStorage();

    }

    function updateAvailability(bool availability) internal {
        assetLogicStorage.setSmartAssetAvailabilityData(availability);
    }

    function initialCollectibleData(uint256 nrSameCollectibles, uint timestamp, bytes32 docUrl, bytes32 _type, bytes32 _name, uint256 id, bytes32 featuresHash) private returns(bool) {
    
        assetLogicStorage.setSmartAssetData(
        nrSameCollectibles,
        sha256(
        nrSameCollectibles,
        timestamp, 
        docUrl, 
        _type, 
        _name, 
        id, 
        featuresHash)
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

    function checkState(uint256 nrSameCollectibles, uint timestamp, bytes32 docUrl, bytes32 _type, bytes32 _name, uint256 id, bytes32 featuresHash) private returns(bool) {
        
        var hash = assetLogicStorage.getSmartAssetData();

        return sha256(
        nrSameCollectibles,
        timestamp, 
        docUrl, 
        _type, 
        _name, 
        id, 
        featuresHash
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
