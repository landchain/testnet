GETH = ../build/bin/geth
PWD = $(shell pwd)
GETH_FLAGS = --identity "landchain-1" \
	--rpc --rpcport "8080" --rpccorsdomain "*" \
	--datadir "data" \
	--port "30303" --nodiscover \
	--rpcapi "db,eth,net,web3" \
	--networkid 1999

genesis.json: alloc-genesis.json.m4
	m4 -DACCOUNT='"0x2a1c04fb0e2f0672488d6f4172f3620ab49437f4"' $< > $@

data:
	$(GETH) $(GETH_FLAGS) init "genesis.json"

account-number: data
	echo 'personal.newAccount("mypassword");' | \
	$(GETH) $(GETH_FLAGS) console | \
	grep '^"0x' > $@

stamps/clean-data: account-number
	(cd data && rm -rf geth)

alloc-genesis.json: alloc-genesis.json.m4 account-number
	m4 -DACCOUNT="`cat account-number`" $< > $@

stamps/blockchain-with-alloc: alloc-genesis.json stamps/clean-data
	$(GETH) $(GETH_FLAGS) init "alloc-genesis.json"

.PHONY: console
console:
	$(GETH) $(GETH_FLAGS) console

