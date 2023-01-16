/* global ethers */
require('dotenv').config()

async function deployDiamondFactory() {
    const diamondFactory = await ethers.getContractAt('DiamondFactory', process.env.DIAMOND_FACTORY_ADDRESS)
    await diamondFactory.createNewEvent("Event Name Test #3", process.env.PUBLIC_KEY)
}

if (require.main === module) {
    deployDiamondFactory()
        .then(() => process.exit(0))
        .catch(error => {
            console.error(error)
            process.exit(1)
        })
}

exports.deployDiamond = deployDiamondFactory

