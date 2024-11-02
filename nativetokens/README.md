## Commands

```bash

aiken check
# or shortcut aiken c
aiken build
# or shortcut aiken b
```

#### for ea_coins
```bash
aiken blueprint policy -m ea_coins -v ea_coins.mint . > ./off-chain/compiled/ea_coins.pid
```

#### for ea_nft
```bash
aiken blueprint convert -m ea_nft -v ea_nft.mint > ./off-chain/compiled/noParams_ea_nft.uplc
```

#### add corresponding params values to utility applyParams
#### and modify apply_params.sh with proper input file and output file parameters

```bash
./apply_params.sh
```

#### Create PID (from the hash of the UPLC Script of the corresponding minting policy)

```bash
cardano-cli conway transaction policyid --script-file ./off-chain/compiled/Params_ea_nft.uplc > ./off-chain/compiled/ea_nft.pid
```