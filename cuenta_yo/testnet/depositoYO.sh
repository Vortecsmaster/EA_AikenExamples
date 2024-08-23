utxoin1="c0fea9c929ea3f24a05ac98465c12135abafc6f70939a9f3b1180e867aef6926#1"
utxoin2="2b3b857454305d6a91543c1bc9f379ce3cde0d4dcc5141da0cbc8a19660ae9b9#0"
address=$(cat cuenta_yo.addr) 
output="90000000"
PREVIEW="--testnet-magic 2"
nami="addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin1 \
  --tx-in $utxoin2 \
  --tx-out $address+$output \
  --tx-out-datum-hash-file ./values/DatumY.json \
  --tx-out $address+$output \
  --tx-out-datum-hash-file ./values/DatumO.json \
  --change-address $nami \
  --out-file giveYO.unsigned

cardano-cli conway transaction sign \
    --tx-body-file giveYO.unsigned \
    --signing-key-file ../../../Wallets/bob.skey \
    --signing-key-file ../../../Wallets/alice.skey \
    $PREVIEW \
    --out-file giveYO.signed

 cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file giveYO.signed