use aiken/dict.{to_pairs}
use aiken/hash.{Blake2b_224, Hash}
use aiken/interval.{Finite}
use aiken/list
use aiken/time.{PosixTime}
use aiken/transaction.{OutputReference, ScriptContext, Transaction, ValidityRange, Mint, TransactionId, Input} as tx
use aiken/transaction/credential.{VerificationKey}
use aiken/transaction/value.{PolicyId,from_minted_value,}
use nativetokens/utils.{dummyTransaction}


type ConditionsRedeemer {
  action: Action,
  deadline: PosixTime,
  owner: PubKeyHash,
  price: Int,
}

//{"constructor":0,fields[{"int":0},{"int": 1713194931000},{"bytes": "d40e3e791bead1fd8c003f1227906b66a2a1c04e59d663798017db71"},{"int": 50}]}

type Action = Int
// 0 -> Owner
// 1 -> Time

type PubKeyHash =
  Hash<Blake2b_224, VerificationKey>


validator(uniqueUTxO: OutputReference, token_name: ByteArray ) {
  fn eaNFT(redeemer: ConditionsRedeemer, sContext: ScriptContext) {
  
    expect Mint(policy_id) = sContext.purpose

    utxoSpent(uniqueUTxO, sContext.transaction)                      &&
    there_can_be_only_ONE(sContext.transaction,policy_id,token_name) && 
    
    when redeemer.action is {
      0  -> must_be_signed_by(sContext.transaction, redeemer.owner)
      1  -> must_happen_before(sContext.transaction.validity_range, redeemer.deadline)
      _  -> False
  }
}
}

fn utxoSpent(utxo_ref: OutputReference, txInfo: Transaction) {
  let Transaction(inputs, ..) = txInfo
  list.any(inputs, fn(input){input.output_reference == utxo_ref })
}

fn there_can_be_only_ONE(txInfo: Transaction, policy_id: PolicyId, token_name: ByteArray) {
  let mint = txInfo.mint
  
  expect [Pair(asset_name, amount)] =
      mint
        |> from_minted_value
        |> value.tokens(policy_id)
        |> dict.to_pairs()
  
  amount == 1 && asset_name == token_name
}

fn must_be_signed_by(transaction: Transaction, vk: PubKeyHash) {
  list.has(transaction.extra_signatories, vk)
}

fn must_happen_before(range: ValidityRange, lock_expiration_time: PosixTime) {
  when range.upper_bound.bound_type is {
    Finite(tx_latest_time) -> lock_expiration_time <= tx_latest_time
    _ -> False
  }
}



// Tests

test utxoSpent_test() {
  let utxo_ref = OutputReference(TransactionId {hash: #"0000000000000000000000000000000000000000000000000000000000000000",}, 0)
  let tx = dummyTransaction()
  utxoSpent(utxo_ref, tx) == True
}