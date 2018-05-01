pragma solidity ^0.4.17;

import './TokenHolder.sol';
import "contracts/utils/Ownable.sol";
import './interfaces/ISmartToken.sol';
import 'contracts/RefungibleToken.sol';

/*
    Smart Token v0.3

    'Owned' is specified here for readability reasons
*/
contract SmartToken is ISmartToken, Ownable, RefungibleToken, TokenHolder {

    string public version = '0.3';

    // triggered when a smart token is deployed - the _token address is defined for forward compatibility, in case we want to trigger the event from a factory
    event NewSmartToken(address _token);
    // triggered when the total supply is increased
    event Issuance(uint256 _amount);
    // triggered when the total supply is decreased
    event Destruction(uint256 _amount);

    /**
        @dev constructor
    */
    function SmartToken()
        public
        RefungibleToken()
    {
        NewSmartToken(address(this));
    }

    /**
        @dev increases the token supply and sends the new tokens to an account
        can only be called by the contract owner

        @param _to         account to receive the new amount
        @param _amount     amount to increase the supply by
    */
    function issue(address _to, uint256 _id, uint256 _amount)
        public
        ownerOnly
        validAddress(_to)
        notThis(_to)
    {
        
        super.assignTokens(_to, _id, _amount);

        Issuance(_amount);
        AssignedTokens(this, _to, _id, _amount);

    }

    /**
        @dev removes tokens from an account and decreases the token supply
        can be called by the contract owner to destroy tokens from any account or by any holder to destroy tokens from his/her own account

        @param _from       account to remove the amount from
        @param _amount     amount to decrease the supply by
    */
    function destroy(address _from, uint256 _id, uint256 _amount) public {
        
        super.destroyTokens(_from, _id, _amount);

        DestroyedTokens(_from, _id, _amount);
        Destruction(_amount);
    }

    /*
        @dev send coins
        throws on any error rather then return a false flag to minimize user errors
        in addition to the standard checks, the function throws if transfers are disabled

        @param _to      target address
        @param _id      id of asset in the refungible token
        @param _value   transfer amount
    */

    function transfer(address _to, uint256 _id, uint256 _value) public returns (bool) {
        return (super.transfer(_to, _id, _value));
    }

    /**
        @dev an account/contract attempts to get the coins
        throws on any error rather then return a false flag to minimize user errors
        in addition to the standard checks, the function throws if transfers are disabled

        @param _from    source address
        @param _to      target address
        @param _value   transfer amount

        @return true if the transfer was successful, false if it wasn't
    */
  /*  function transferFrom(address _from, address _to, uint256 id, uint256 _value) public transfersAllowed returns (bool success) {
        super.transferFrom(_from, _to, id, _value);
        return true;
    } */
}
