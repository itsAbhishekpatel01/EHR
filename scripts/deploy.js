async function main() {
    // Get the deployer account
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy Registry contract
    const Registry = await ethers.getContractFactory("Registry");
    const registry = await Registry.deploy();
    await registry.deployed();  // Ensure this is a valid method

    console.log("Registry contract deployed to:", registry.address);

    // Deploy PermissionContract with the address of the deployed Registry contract
    const PermissionContract = await ethers.getContractFactory("PermissionContract");
    const permissionContract = await PermissionContract.deploy(registry.address);
    await permissionContract.deployed();  // Ensure this is a valid method

    console.log("PermissionContract deployed to:", permissionContract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
