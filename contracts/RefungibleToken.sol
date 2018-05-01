pragma solidity ^0.4.17;

import "contracts/utils/Ownable.sol";
import "contracts/utils/math/SafeMath.sol";

contract RefungibleToken is Ownable {

	using SafeMath for uint256;

	event Minted(uint256 _id, string _proof);
	event Destroyed(uint256 _id);
	event AssignedTokens(address indexed _from, address indexed _to, uint256 _id, uint256 _amount);
	event DestroyedTokens(address indexed _from, uint256 _id, uint256 _units);
	event Transfer(address _sender, address _to, uint256 _id, uint256 _units);

	struct NFT {

		bool exists;
		string proof;
		uint256 divisibility;
		uint256 inCirculation;

	}

	bool public transfersEnabled = true;    // true if transfer/transferFrom are enabled, false if not

	// ------------------------------ Variables ------------------------------

	// Percentage of ownership over a token
	mapping(address => mapping(uint => uint)) ownerToTokenShare;

    // How much owners have of a token
    mapping(uint => mapping(address => uint)) tokenToOwnersHoldings;

    // If a token has been created
    mapping(uint => NFT) mintedToken;

	// Number of equal(fungible) units that constitute a token (that a token can be divised to)
	uint public _divisibility = 100000;

	// total of managed/tracked tokens by this smart contract
	uint public totalSupply;


	// ------------------------------ Modifiers ------------------------------

	modifier onlyNonExistentToken(uint _tokenId) {
	    require(mintedToken[_tokenId].exists == false);
	    _;
	}

	modifier onlyExistentToken(uint _tokenId) {
	    require(mintedToken[_tokenId].exists == true);
	    _;
	}

	// allows execution only when transfers aren't disabled
    modifier transfersAllowed {
        assert(transfersEnabled);
        _;
    }

    function RefungibleToken() {

        owner = msg.sender;

    }

	// ------------------------------ View functions ------------------------------

	/// @dev The balance of an owner over an asset
	function unitsOwnedOfAToken(address _owner, uint _tokenId) public view returns (uint _balance)
	{
	    return ownerToTokenShare[_owner][_tokenId];
	}

	
	// ------------------------------ Core public functions ------------------------------

	 /**
        @dev disables/enables transfers
        can only be called by the contract owner

        @param _disable    true to disable transfers, false to enable them
    */
    function disableTransfers(bool _disable) public onlyOwner {
        transfersEnabled = !_disable;
    }

	/// @dev Only the owner can create a token in our example
	/// @notice Minting grants 100% of the token to the owner in our example
	function mint(uint _tokenId, string _proof) public onlyOwner onlyNonExistentToken (_tokenId)
	{	

		require(bytes(_proof).length > 0);

		mintedToken[_tokenId].exists = true;
		mintedToken[_tokenId].proof = _proof;
		mintedToken[_tokenId].divisibility = _divisibility;

		totalSupply = totalSupply.add(1);

		Minted(_tokenId, _proof); // emit event

	}

	function destroy(uint _tokenId) public onlyOwner onlyExistentToken(_tokenId) {

		require(mintedToken[_tokenId].inCirculation == 0);
		delete(mintedToken[_tokenId]);

		Destroyed(_tokenId);

	}

	function assignTokens(address _to, uint256 _id, uint256 _amount) public onlyExistentToken(_id) onlyOwner {

		require(_to != address(0));
		require(mintedToken[_id].inCirculation.add(_amount) <= mintedToken[_id].divisibility);

		_addShareToNewOwner(_to, _id, _amount);
		_addNewOwnerHoldingsToToken(_to, _id, _amount);

		mintedToken[_id].inCirculation = mintedToken[_id].inCirculation.add(_amount);

	}

	function destroyTokens(address _from, uint256 _id, uint256 _amount) public onlyExistentToken(_id) {

		require(msg.sender == _from || msg.sender == owner); // validate input
		require(mintedToken[_id].inCirculation.sub(_amount) >= 0);

		_removeShareFromLastOwner(msg.sender, _id, _amount);
		_removeLastOwnerHoldingsFromToken(msg.sender, _id, _amount);

		mintedToken[_id].inCirculation = mintedToken[_id].inCirculation.sub(_amount);

	}

	/// @dev transfer parts of a token to another user
	function transfer(address _to, uint _tokenId, uint _units) public onlyExistentToken(_tokenId) transfersAllowed returns (bool)
	{

		require(ownerToTokenShare[msg.sender][_tokenId] >= _units);
		require(_to != address(0));

		_removeShareFromLastOwner(msg.sender, _tokenId, _units);
		_removeLastOwnerHoldingsFromToken(msg.sender, _tokenId, _units);

		_addShareToNewOwner(_to, _tokenId, _units);
		_addNewOwnerHoldingsToToken(_to, _tokenId, _units);

		Transfer(msg.sender, _to, _tokenId, _units); // emit event

		return true;

	}
	

	// ------------------------------ Helper functions (internal functions) ------------------------------

	// Remove token units from last owner
	function _removeShareFromLastOwner(address _owner, uint _tokenId, uint _units) internal
	{
		ownerToTokenShare[_owner][_tokenId] -= _units;
	}

	// Add token units to new owner
	function _addShareToNewOwner(address _owner, uint _tokenId, uint _units) internal
	{
		ownerToTokenShare[_owner][_tokenId] += _units;
	}

    // Remove units from last owner 
    function _removeLastOwnerHoldingsFromToken(address _owner, uint _tokenId, uint _units) internal
    {
        tokenToOwnersHoldings[_tokenId][_owner] -= _units;
    }

	// Add the units to new owner
	function _addNewOwnerHoldingsToToken(address _owner, uint _tokenId, uint _units) internal
	{
		tokenToOwnersHoldings[_tokenId][_owner] += _units;
	}

}