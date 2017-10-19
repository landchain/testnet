geth \
	--identity "landchain-1" \
	--rpc --rpcport "8080" --rpccorsdomain "*" \
	--datadir "/Users/jaakko/Projects/landchain-testnet/data" \
	--port "30303" --nodiscover \
	--rpcapi "db,eth,net,web3" \
	--networkid 1999 \
	init /Users/jaakko/Projects/landchain-testnet/genesis.json
