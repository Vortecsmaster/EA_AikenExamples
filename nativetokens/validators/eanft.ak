use aiken/dict
use aiken/hash.{Blake2b_224, Hash}
use aiken/interval.{Finite}
use aiken/list
use aiken/time.{PosixTime}
use aiken/transaction.{OutputReference, ScriptContext, Transaction, ValidityRange} as tx
use aiken/transaction/credential.{VerificationKey}
use aiken/transaction/value.{PolicyId}

type ConditionsRedeemer {
  action: Action,
  deadline: PosixTime,
  owner: VerificationKeyHash,
  price: Int,
}

//{"constructor":0,fields[{"constructor":0,fields:[]},{"int": 1713194931000},{"bytes": "d40e3e791bead1fd8c003f1227906b66a2a1c04e59d663798017db71"},{"int": 50}]}



//"data Action = Owner | Time" | Price

type Action {
  Owner //{"constructor":0,fields:[]}
  Time  //"constructor":1,fields:[]} 
 // Price //"constructor":2,fields:[]}
}


type VerificationKeyHash =
  Hash<Blake2b_224, VerificationKey>

validator(txOutRef: OutputReference, token_name: ByteArray ) {
  fn eaNFT(redeemer: ConditionsRedeemer, ctx: ScriptContext) {
    let purpose = ctx.purpose
    
    expect tx.Mint(policy_id) = purpose

    utxoSpent(txOutRef, ctx.transaction)                        &&
    there_can_be_only_ONE(ctx.transaction,policy_id,token_name) && 
    
    when redeemer.action is {
      Owner -> must_be_signed_by(ctx.transaction, redeemer.owner)
      Time  -> must_happen_before(ctx.transaction.validity_range, redeemer.deadline)
    }
  }
}

fn utxoSpent(utxo_ref: OutputReference, txInfo: Transaction) {
  let Transaction(inputs, ..) = txInfo
  list.any(inputs, fn(input){input.output_reference == utxo_ref })
}

fn there_can_be_only_ONE(txInfo: Transaction, policy_id: PolicyId, token_name: ByteArray) {
  let mint = txInfo.mint
  
  expect [(asset_name, amount)] =
      mint
        |> value.from_minted_value
        |> value.tokens(policy_id)
        |> dict.to_list()
  
  amount == 1 && asset_name == token_name
}

fn must_be_signed_by(transaction: Transaction, vk: VerificationKeyHash) {
  list.has(transaction.extra_signatories, vk)
}

fn must_happen_before(range: ValidityRange, lock_expiration_time: PosixTime) {
  when range.upper_bound.bound_type is {
    Finite(tx_latest_time) -> lock_expiration_time <= tx_latest_time
    _ -> False
  }
}
