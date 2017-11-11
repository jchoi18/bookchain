var Textbook = artifacts.require("./Textbook.sol");

module.exports = function(deployer) {
    deployer.deploy(Textbook);
};