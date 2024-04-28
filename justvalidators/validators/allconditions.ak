use aiken/hash.{Blake2b_224, Hash}
use aiken/interval.{Finite, before}
use aiken/list
use aiken/dict
use aiken/transaction.{ScriptContext, Transaction, ValidityRange, TransactionId, Spend, OutputReference}
use aiken/transaction/credential.{VerificationKey}
use aiken/transaction/value.{from_lovelace, to_minted_value}

type ConditionsDatum {
  deadline: POSIXtime,
  owner: VerificationKeyHash,
  price: Int,
}

type VerificationKeyHash =
  Hash<Blake2b_224, VerificationKey>

type POSIXtime =
  Int


validator {
  fn allConditions(datum: ConditionsDatum, _redeemer: Int, ctx: ScriptContext) -> Bool {
      must_be_signed_by(ctx.transaction, datum.owner) && must_happen_before(ctx.transaction.validity_range, datum.deadline)
  }
}


fn must_be_signed_by(transaction: Transaction, vk: VerificationKeyHash) {
  list.has(transaction.extra_signatories, vk)
}

fn must_happen_before(range: ValidityRange, lock_expiration_time: POSIXtime) {
  when range.upper_bound.bound_type is {
    Finite(tx_latest_time) -> lock_expiration_time >= tx_latest_time
    _ -> False
  }
}

test allConditionsFullfilled() {
  
   let dat = ConditionsDatum {
      deadline: 999999999,
      owner:  "1234567890abcdef",
      price: 50 
   }

      
   let daContext = ScriptContext { 
      transaction: Transaction {
                 inputs: [],
       reference_inputs: [],
                outputs: [],
                   fee: from_lovelace(0),
                  mint: to_minted_value(from_lovelace(0)),
           certificates: [],
           withdrawals: dict.new(),
          validity_range: before(999999998),
        extra_signatories: ["1234567890abcdef"],
                redeemers: dict.new(),
                   datums: dict.new(),
                        id: TransactionId(""),
      },
      purpose: Spend(OutputReference { transaction_id: TransactionId(""), output_index: 0 })
    }

    allConditions(dat, 0, daContext)
}
