pragma solidity ^0.4.17;

contract IRefungibleToken {

    event Minted(address _proof);

    function changeDivisibility(uint256 newDivisibility) public;

    function changeSmartToken(address newSmartToken) public;

    function mint(address _proof) public;

    function addInCirculation(uint256 _tokens) public;

    function getDivisibility() public constant returns (uint256);

    function removeFromCirculation(uint256 _tokens) public;

}