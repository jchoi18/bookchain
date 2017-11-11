var ProofOfExistence1 = artifacts.require("./ProofOfExistence1.sol");
var MyToken = artifacts.require("./MyToken.sol");
var Textbook = artifacts.require("./Textbook.sol");

module.exports = function(deployer) {
    deployer.deploy(ProofOfExistence1);
    deployer.deploy(Textbook);
    deployer.deploy(MyToken);
};