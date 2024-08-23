#### Derive address from script
## cardano-cli address build --payment-script-file ./compiled/cuenta_yo.uplc --testnet-magic 2 --out-file cuenta_yo.addr

#### PubKeyHash creation:
## cardano-cli address key-hash --payment-verification-key-file verificationKey.vkey --out-file verificationKey.pkh

#### Serializing contracts from blueprint for cardano CLI
# aiken blueprint convert -m cuenta_yo -v cuenta_yo . > cuenta_yo.uplc

#### echo "{\"constructor\" : 0, \"fiels\": [{\"}]}