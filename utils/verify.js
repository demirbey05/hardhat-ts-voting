const hre = require("hardhat");

async function verify(contractAddress, constructorArguments) {
  console.log("Verifying contract...");
  try {
    await hre.run("verify:verify", {
      address: contractAddress,
      constructorArguments: constructorArguments,
    });
  } catch (e) {
    if (e.message.toLowerCase().includes("already verified")) {
      console.log("Already verified!");
    } else {
      console.log(e);
    }
  }
}

module.exports = { verify };
