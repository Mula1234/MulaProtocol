pragma solidity ^0.4.15;

//import "./DhOraclizeBase.sol";
import "./SmartAssetLogicStorage.sol";


contract IotSimulationInterface {
    function generateIotOutput(uint24 id, uint salt) returns (bool result);
    function generateIotAvailability(uint24 id, bool availability) returns (bool result);
}


/**
 * @title Car smart asset logic  contract
 */
contract CarAssetLogic {

    address private iotSimulationAddr;

    SmartAssetLogicStorage assetLogicStorage;

    /**
    * City that have been added to this contract with their lat longs
    */
    bytes32[] cities;

    /**
     * Construct encapsulating latitude and longitude pair
     */
    struct LatLong {
        bytes11 lat;
        bytes11 long;
        bool initialized;
    }

    // Mapping city to its latitude longitude pair
    mapping (bytes32 => LatLong) cityMapping;


    /**
     * Check whether IotSimulator contract executes method or not
     */
    modifier onlyIotSimulator {
        require(msg.sender == iotSimulationAddr);
        _;
    }

    function CarAssetLogic() {
        
        assetLogicStorage = new SmartAssetLogicStorage();

    }

    function updateAvailability(bool availability) internal {
        assetLogicStorage.setSmartAssetAvailabilityData(availability);
    }

    function initialCarData(uint256 nrOfIdenticalCars, uint timestamp, bytes32 docUrl, uint8 smoker, bytes32 email, bytes32 model, bytes32 vin, bytes32 color, uint millage) private returns(bool) {
    
        assetLogicStorage.setSmartAssetData(
        nrOfIdenticalCars,
        sha256(
        nrOfIdenticalCars,
        timestamp,
        docUrl,
        smoker,
        email,
        model,
        vin,
        color,
        millage)
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

    function checkState(uint256 nrCars, uint timestamp, bytes32 docUrl, uint8 smoker, bytes32 email, bytes32 model, bytes32 vin, bytes32 color, uint millage) private returns(bool) {
        
        var hash = assetLogicStorage.getSmartAssetData();

        return sha256(
        nrCars,
        timestamp,
        docUrl,
        smoker,
        email,
        model,
        vin,
        color,
        millage
        ) == hash;

    } */

    /**
        * Gets all cities that have been added to this contract
        *@return cities all cities that have been added to this contract
        */
    function getAvailableCities() constant returns (bytes32[]) {
        return cities;
    }


    function getSmartAssetAvailability() constant returns (bool availability) {
        return assetLogicStorage.getSmartAssetAvailability();
    }

    /**
    * Adds city with lat long to this contract. If a city has already been added replaces old
    * lat long with the new one
    *@param cityName name of the city to be added
    *@param lat latitude of the city to be added
    *@param long longitude of the city to be added
    */
    function addCity(bytes32 cityName, bytes11 lat, bytes11 long) onlyOwner() {
        LatLong latLong = cityMapping[cityName];
        if (latLong.initialized == false) {
            cities.push(cityName);
        }

        cityMapping[cityName] = LatLong(lat, long, true);
    }

    /**
     * @dev Setter for the SmartAsset contract address
     * @param contractAddress Address of the IotSimulation contract
     */
    function setIotSimulationAddr(address contractAddress) onlyOwner returns (bool result) {
        require(contractAddress != address(0));
        iotSimulationAddr = contractAddress;
        return true;
    }

    /**
     * @dev Max function
     */
    function max(uint a, uint b) private returns (uint) {
        return a > b ? a : b;
    }

    /**
     * @dev Min function
     */
    function min(uint a, uint b) private returns (uint) {
        return a < b ? a : b;
    }

    /**
     * @dev Transforms bool value to uint
     */
    function boolToInt(bool input) private returns (uint) {
        return input == true ? 1 : 0;
    }

    function setCarAssetLogicStorage(address _carAssetLogicStorage) onlyOwner {
        carAssetLogicStorage = CarAssetLogicStorage(_carAssetLogicStorage);
    }

}
