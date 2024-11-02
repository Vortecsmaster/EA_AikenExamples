utxoin1="d1100706ed94be06ac67166eba04b13f38b02f3af6004b800b37668bc1fbc41f#0"
utxoin2="038a4524946d09a9fb8572a4cc6121493f9f72a1f32f347720a9bf4ebc178e71#0"
address=$(cat cuenta_yo_V3.addr) 
output="90000000"
PREVIEW="--testnet-magic 2"
nami="addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin1 \
  --tx-in $utxoin2 \
  --tx-out $address+$output \
  --tx-out-datum-hash-file ../values/DatumY.json \
  --tx-out $address+$output \
  --tx-out-datum-hash-file ../values/DatumO.json \
  --change-address $nami \
  --out-file giveYO.unsigned

cardano-cli conway transaction sign \
    --tx-body-file giveYO.unsigned \
    --signing-key-file $HOME/Dev/Wallets/Bob.skey \
    --signing-key-file $HOME/Dev/Wallets/IAlice.skey \
    $PREVIEW \
    --out-file giveYO.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file giveYO.signed