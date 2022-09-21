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
  await deploy("VotingAutomated", {
    from: deployer,
    args: ["15"],
    log: true,
  });

  const contractAddress = (await deployments.get("VotingAutomated")).address;
  if (network.config.chainId == 5) {
    await verify(contractAddress, ["15"]);
  }
};
module.exports.tags = ["all", "voting-automated"];
