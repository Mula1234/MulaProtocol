pragma solidity ^0.4.17;

//import "./DhOraclizeBase.sol";
import "./SmartAssetLogicStorage.sol";

contract ProductServiceAssetLogic {

    SmartAssetLogicStorage assetLogicStorage;

    function ProductServiceAssetLogic() {
        
        assetLogicStorage = new SmartAssetLogicStorage();

    }

    function updateAvailability(bool availability) internal {
        assetLogicStorage.setSmartAssetAvailabilityData(availability);
    }

    function initialProductServiceData(uint timestamp, bytes32 docUrl, bytes32 _name, bytes32 description, bytes32 trademark) private returns(bool) {
    
        assetLogicStorage.setSmartAssetData(
        1,
        sha256(
        1,
        timestamp, 
        docUrl,
        _name, 
        description, 
        trademark)
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

    function checkState(uint timestamp, bytes32 docUrl, bytes32 _name, bytes32 description, bytes32 trademark) private returns(bool) {
        
        var hash = assetLogicStorage.getSmartAssetData();

        return sha256(
        1,
        timestamp, 
        docUrl,
        _name, 
        description, 
        trademark
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
