/* global artifacts */
/* eslint-disable prefer-reflect */

const Utils = artifacts.require('contracts/bancor/Utils.sol');
const Owned = artifacts.require('contracts/bancor/Owned.sol');
const Managed = artifacts.require('contracts/bancor/Managed.sol');
const TokenHolder = artifacts.require('contracts/bancor/TokenHolder.sol');
const ERC20Token = artifacts.require('contracts/bancor/ERC20Token.sol');
const EtherToken = artifacts.require('contracts/bancor/EtherToken.sol');
const SmartToken = artifacts.require('contracts/bancor/SmartToken.sol');
const SmartTokenController = artifacts.require('contracts/bancor/SmartTokenController.sol');
const BancorFormula = artifacts.require('contracts/bancor/BancorFormula.sol');
const BancorGasPriceLimit = artifacts.require('contracts/bancor/BancorGasPriceLimit.sol');
const BancorQuickConverter = artifacts.require('contracts/bancor/BancorQuickConverter.sol');
const BancorConverterExtensions = artifacts.require('contracts/bancor/BancorConverterExtensions.sol');
const BancorConverter = artifacts.require('contracts/bancor/BancorConverter.sol');
const CrowdsaleController = artifacts.require('contracts/bancor/CrowdsaleController.sol');
const RefungibleToken = artifacts.require('contracts/RefungibleToken.sol');

module.exports = async (deployer, network, accounts) => {

    await deployer.deploy(Utils);
    await deployer.deploy(Owned);
    await deployer.deploy(Managed);
    await deployer.deploy(TokenHolder);
    await deployer.deploy(ERC20Token, 'DummyToken', 'DUM', 0);
    await deployer.deploy(EtherToken);
    await deployer.deploy(SmartToken, 'Token1', 'TKN1', 2);
    await deployer.deploy(SmartTokenController, SmartToken.address);
    await deployer.deploy(BancorFormula);
    await deployer.deploy(BancorGasPriceLimit, '22000000000');
    await deployer.deploy(BancorQuickConverter);
    await deployer.deploy(BancorConverterExtensions, '0x125463', '0x145463', '0x125763');
    await deployer.deploy(BancorConverter, SmartToken.address, '0x124', 0, '0x0', 0);
    await deployer.deploy(CrowdsaleController, SmartToken.address, 4102444800, '0x125', '0x126', 1);
    await deployer.deploy(RefungibleToken);

};
