https://lightrains.com/blogs/setup-local-ethereum-blockchain-private-testnet
https://github.com/ethereum/go-ethereum/wiki/Private-network
http://ethdocs.org/en/latest/network/test-networks.html

personal.newAccount("password")

primary = eth.accounts[0]
balance = web3.fromWei(eth.getBalance(primary), "ether");
