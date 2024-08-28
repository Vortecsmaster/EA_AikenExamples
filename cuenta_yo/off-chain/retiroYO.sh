utxoin1="823c548e1d16c0a9f6f84610d4a20d0e83e9947f6781686dba2eedcb32c74649#0"
#address=$(cat ../../../Wallets/payment2.addr) 
output="80000000"
collateral="ec46d7b575e29e0f5f1c86cab61a90988d7b84d6189e504c34cbcbc8e03e5045#0"
nami="addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt"
PREVIEW="--testnet-magic 2"
bobPKH=$(cat ../../../Wallets/bob.pkh)
alicePKH=$(cat ../../../Wallets/alice.pkh)
cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin1 \
  --tx-in-script-file ./compiled/cuenta_yo.uplc \
  --tx-in-datum-file ./values/DatumY.json \
  --tx-in-redeemer-file ./values/value1.json \
  --required-signer-hash $bobPKH \
  --required-signer-hash $alicePKH \
  --tx-in-collateral $collateral \
  --tx-out $nami+$output \
  --change-address $nami \
  --out-file retiroYO.unsigned

cardano-cli transaction sign \
    --tx-body-file retiroYO.unsigned \
    --signing-key-file ../../../Wallets/alice.skey \
    --signing-key-file ../../../Wallets/bob.skey \
    $PREVIEW \
    --out-file retiroYO.signed
 
 cardano-cli transaction submit \
    $PREVIEW \
    --tx-file retiroYO.signed