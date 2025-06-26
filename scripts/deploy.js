async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Voting = await ethers.getContractFactory("DecentralizedVotingSystem");
  const voting = await Voting.deploy();

  await voting.deployed();

  console.log("DecentralizedVotingSystem deployed to:", voting.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
