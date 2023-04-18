require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const API_URL = "https://goerli.infura.io/v3/";
const PRIVATE_KEY = "09e595b16f225d49cf89ca37515c68421923e010431dadb3e5bb1f8a36a0c986";
const PUBLIC_KEY = "0x1d5e669d6B6B51f9e3833BdCBc1b572e68078025";

require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.18",
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/7e62f3b2482d4e0aa0c7706ff8d9549c",
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    }
  }
};