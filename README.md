npm install

For local

terminal 1 : npx hardhat node 
terminal 2 : npx hardhat run --network localhost scripts/deploy.js

For external chains (Arbitrum goerli is configured by default in hardhat.config taking .env variables)

npx hardhat run scripts/deploy.js --network goerli