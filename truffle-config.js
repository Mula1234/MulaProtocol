module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*",
      from: "0xc9d9d4e888e0e30f570cc01ffae964805c0711c5",
      gas: "7000000",
      gasPrice: "1000000000"
    }
  }
};