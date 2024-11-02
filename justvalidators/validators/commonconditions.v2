use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use aiken/interval.{Finite}
use cardano/transaction.{OutputReference, Transaction, ValidityRange}

pub type PosixTime =
  Int

pub type ConditionsDatum {
  deadline: PosixTime,
  owner: VerificationKeyHash,
  price: Int,
}

pub type ActionRedeemer {
  Owner
  Time
}

pub type OurWonderfullDatum {
  owd: Int,
}

pub type OurWonderfullRedeemer {
  owr: Int,
}

validator our_wonderfull_validator {
  spend(
    datum: Option<OurWonderfullDatum>,
    redeemer: OurWonderfullRedeemer,
    _output_reference: OutputReference,
    _transaction: Transaction,
  ) {
    expect Some(data) = datum
    (data.owd == redeemer.owr)?
  }

  else(_) {
    fail
  }
}

validator conditionator {
  spend(
    datum: Option<ConditionsDatum>,
    redeemer: ActionRedeemer,
    _output_reference: OutputReference,
    transaction: Transaction,
  ) {
    expect Some(data) = datum
    let ConditionsDatum { owner, deadline, .. } = data
    when redeemer is {
      Owner -> must_be_signed_by(transaction, owner)?
      Time -> must_happen_before(transaction.validity_range, deadline)?
    }
  }

  else(_) {
    fail
  }
}

fn must_be_signed_by(transaction: Transaction, vk: VerificationKeyHash) {
  transaction.extra_signatories |> list.has(vk)
}

fn must_happen_before(range: ValidityRange, lock_expiration_time: PosixTime) {
  when range.upper_bound.bound_type is {
    Finite(tx_latest_time) -> (lock_expiration_time >= tx_latest_time)?
    _ -> False
  }
}
