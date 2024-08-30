use aiken/dict
use aiken/interval.{before}
use aiken/transaction.{OutputReference, Transaction, TransactionId, Output, NoDatum, Input} as tx
use aiken/transaction/credential.{from_verification_key}
use aiken/transaction/value.{from_lovelace, to_minted_value, merge, from_asset}


pub fn dummyTransaction() -> Transaction {
 
  let utxo_ref = OutputReference(TransactionId {hash: #"0000000000000000000000000000000000000000000000000000000000000000",}, 0)
  let token_value = from_asset("41D0",#"6e6f5f6e616d655f746f6b656e", 1) 
  let tx_value = merge(from_lovelace(11000000), token_value)
  let dummy_addr = from_verification_key(#"2070f8488dd696b78a5f23e38d273550e43660526c4b19cba733b488") //Address{VerificationKeyCredential{"AD812"}, None}
  let output = Output(dummy_addr, tx_value, NoDatum, None)
  let input = Input(utxo_ref,Output(dummy_addr, from_lovelace(50000000), NoDatum, None))
  let minted_value = to_minted_value(token_value)
  let tx = Transaction(
      [input],
      [],
      [output],
       from_lovelace(2000000),
       minted_value,
       [],
       [],
        before(1000000000),
       [],  //signatores
       [],  //redeemers
       dict.new(),  //datums
       TransactionId("AD812"))
 
    tx
}