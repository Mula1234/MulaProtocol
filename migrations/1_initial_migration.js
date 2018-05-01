var Migrations = artifacts.require("./Migrations.sol");
var BancorFormula = artifacts.require('contracts/bancor/BancorFormula.sol');

module.exports = function(deployer) {
  
  deployer.deploy(Migrations);
  deployer.deploy(BancorFormula);

}
