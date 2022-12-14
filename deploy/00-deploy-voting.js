const {
  getNamedAccounts,
  deployments,
  ethers,
  network,
  log,
} = require("hardhat");
const { verify } = require("../utils/verify.js");
module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  await deploy("Voting", {
    from: deployer,
    log: true,
  });

  const contractAddress = (await deployments.get("Voting")).address;
  if (network.config.chainId == 5) {
    await verify(contractAddress);
  }
};
module.exports.tags = ["all", "voting"];
