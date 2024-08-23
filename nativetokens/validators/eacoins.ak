use aiken/hash.{Blake2b_224, Hash}
use aiken/interval.{Finite}
use aiken/list
use aiken/time.{PosixTime}
use aiken/transaction.{ScriptContext, Transaction, ValidityRange}
use aiken/transaction/credential.{VerificationKey}

type ConditionsRedeemer {
  action: Action,
  deadline: PosixTime,
  owner: VerificationKeyHash,
  price: Int,
}

//{"constreaNFTctor":0,fields[{"constructor":0,fields:[]},{"int": 1713194931000},{"bytes": "d40e3e791bead1fd8c003f1227906b66a2a1c04e59d663798017db71"},{"int": 50}]}

type Action {
  Owner
  //{"constructor":0,fields:[]}
  Time
}

//"constructor":1,fields:[]} 

type VerificationKeyHash =
  Hash<Blake2b_224, VerificationKey>

validator {
  fn eaCoins(redeemer: ConditionsRedeemer, ctx: ScriptContext) -> Bool {
    when redeemer.action is {
      Owner -> must_be_signed_by(ctx.transaction, redeemer.owner)
      Time ->
        must_happen_before(ctx.transaction.validity_range, redeemer.deadline)
    }
  }
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
