PWD = $(shell pwd)
GETH_FLAGS = --identity "landchain-1" \
	--rpc --rpcport "8080" --rpccorsdomain "*" \
	--datadir "data" \
	--port "30303" --nodiscover \
	--rpcapi "db,eth,net,web3" \
	--networkid 1999
GETH_PATH = ../build/bin/geth
GETH = $(GETH_PATH) $(GETH_FLAGS)

all: miner.pid

genesis.json: alloc-genesis.json.m4
	m4 -DACCOUNT='"0x2a1c04fb0e2f0672488d6f4172f3620ab49437f4"' $< > $@

stamps/create-datadir: genesis.json
	$(GETH) init "genesis.json"
	touch $@

account-number: stamps/create-datadir
	echo 'personal.newAccount("mypassword");' | \
	$(GETH) console | \
	grep '^"0x' > $@

alloc-genesis.json: alloc-genesis.json.m4 account-number
	m4 -DACCOUNT="`cat account-number`" $< > $@

stamps/clean-data: account-number
	(cd data && rm -rf geth)
	touch $@

stamps/blockchain-with-alloc: alloc-genesis.json stamps/clean-data
	$(GETH) init "alloc-genesis.json"
	touch $@

miner.pid: stamps/blockchain-with-alloc account-number
	$(GETH) --etherbase=$(shell cat account-number | tr -d '"') \
	--mine --minerthreads 1 --maxpeers 0 --verbosity 3 \
	--gasprice 20000000000 --unlock 0 --password password-file \
	> miner.log 2>&1 & echo $$! > $@

.PHONY: kill-miner
kill-miner:
	kill $(shell cat miner.pid) && rm miner.pid

.PHONY: console
console:
	$(GETH_PATH) attach ipc:./data/geth.ipc

.PHONY: test-console
test-console:
	$(GETH) console

