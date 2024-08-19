use aiken/hash.{Blake2b_224, Hash}
use aiken/interval.{Finite}
use aiken/list
use aiken/transaction.{ScriptContext, Transaction, ValidityRange}
use aiken/transaction/credential.{VerificationKey}

type ConditionsDatum {
  deadline: POSIXtime,
  owner: VerificationKeyHash,
  price: Int,
}

type VerificationKeyHash =
  Hash<Blake2b_224, VerificationKey>

type POSIXtime =
  Int

type ActionRedeemer {
  Owner
  Time
}

type OurWonderfullDatum {
  owd: Int,
}

type OurWonderfullRedeemer {
  owr: Int,
}

validator {
  fn ourWonderfullValidator(
    datum: OurWonderfullDatum,
    redeemer: OurWonderfullRedeemer,
    _context: Data,
  ) -> Bool {
    datum.owd == redeemer.owr
  }
}

validator {
  fn conditionator(
    datum: ConditionsDatum,
    redeemer: ActionRedeemer,
    ctx: ScriptContext,
  ) -> Bool {
    when redeemer is {
      Owner -> must_be_signed_by(ctx.transaction, datum.owner)
      Time -> must_happen_before(ctx.transaction.validity_range, datum.deadline)
    }
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
