const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying EventTicketing contract from:", deployer.address);

  const EventTicketing = await hre.ethers.getContractFactory("EventTicketing");
  const eventTicketing = await EventTicketing.deploy();
  await eventTicketing.deployed();

  console.log("✅ EventTicketing contract deployed at:", eventTicketing.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
