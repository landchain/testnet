geth \
	--identity "landchain-1" \
	--rpc --rpcport "8080" --rpccorsdomain "http://35.158.85.118:3000/" \
	--datadir "/Users/jaakko/Projects/landchain-testnet/data" \
	--port "30303" --nodiscover \
	--rpcapi "db,eth,net,web3" \
	--networkid 1999 \
	--etherbase=0xddbbf126b6b3e9243e6351a5ff16d01bd967c4e1 \
	--unlock 0 --password /Users/jaakko/Projects/landchain-testnet/password
