var ProofOfExistence1 = artifacts.require("./ProofOfExistence1.sol");
var MyToken = artifacts.require("./MyToken.sol");

module.exports = function(deployer) {
    deployer.deploy(ProofOfExistence1);
    deployer.deploy(MyToken);
};