script_utxo="ed253397ede119530cf16a37ed2606108ab88c6270c86141619122db610cea91#0"
script_address=$(cat ../compiled/savings.addr) 
user_utxo="7043f15b0b878f1c1d2197570351c33697b354e23d362256bf78fe737d893207#0"
output="7000000000"
saverPKH=$(cat $HOME/Dev/Wallets/Adr08.pkh)
collateralPKH=$(cat $HOME/Dev/Wallets/Adr07.pkh)
collateral="4cbf990857530696a12b0062546a4b123ad0bef21c67562e32d03e3288bdcd7b#0"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $script_utxo \
  --tx-in-script-file ../compiled/savings.uplc \
  --tx-in-datum-file ../values/saver.json \
  --tx-in-redeemer-file ../values/value1.json \
  --tx-in $user_utxo \
  --required-signer-hash $saverPKH \
  --tx-in-collateral $collateral \
  --tx-out $script_address+$output \
  --tx-out-datum-hash-file ../values/saver.json \
  --change-address $nami3 \
  --out-file another_deposit.unsigned

cardano-cli conway transaction sign \
    --tx-body-file another_deposit.unsigned \
    --signing-key-file $HOME/Dev/Wallets/Adr08.skey \
    --signing-key-file $HOME/Dev/Wallets/Adr07.skey \
    $PREVIEW \
    --out-file another_deposit.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file another_deposit.signed