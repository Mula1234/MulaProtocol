pragma solidity ^0.4.17;

import "contracts/utils/Ownable.sol";
import "contracts/utils/math/SafeMath.sol";
import "contracts/mulaInterfaces/IRefungibleToken.sol";

contract RefungibleToken is Ownable, IRefungibleToken {

	using SafeMath for uint256;

	// Number of equal(fungible) units that constitute a token (that a token can be divised to)
	uint256 public _divisibility = 100000;

	// total number of contracts registered in this contract
	uint256 public nrOfAssets;

	uint256 public inCirculation;

	address assetInformation;

	address smartToken;

	modifier onlyOneAsset {

		require(nrOfAssets == 1);
		_;

	}

	modifier maximumOneAsset {

		require(nrOfAssets < 1);
		_;

	}

	modifier nothingInCirculation {

		require(inCirculation == 0);
		_;

	}

	modifier onlySmartToken {

		require(msg.sender == smartToken);
		_;

	}

    function RefungibleToken() {

        owner = msg.sender;

    }

	function changeDivisibility(uint256 newDivisibility) public onlyOwner nothingInCirculation {

		_divisibility = newDivisibility;

	}

	function changeSmartToken(address newSmartToken) public onlyOwner {

		smartToken = newSmartToken;

	}

	
	/// @dev Only the owner can create a token in our example
	function mint(address _proof) public onlyOwner maximumOneAsset
	{	

		require(_proof != address(0));

		assetInformation = _proof;

		nrOfAssets = nrOfAssets.add(1);

		Minted(_proof);

	}

	function addInCirculation(uint256 _tokens) public onlySmartToken {

		require(inCirculation.add(_tokens) <= _divisibility);

		inCirculation = inCirculation.add(_tokens);

	}

	function getDivisibility() public constant returns (uint256) {

		return _divisibility;

	}

}