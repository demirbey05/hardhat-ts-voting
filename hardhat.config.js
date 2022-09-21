/** @type import('hardhat/config').HardhatUserConfig */
require("hardhat-deploy");
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");

const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;

module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 5,
    },
  },

  mocha: {
    timeout: 40000,
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },

  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};
