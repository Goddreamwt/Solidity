var Migrations = artifacts.require("./BloggerCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
