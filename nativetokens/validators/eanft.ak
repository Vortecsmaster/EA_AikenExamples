use aiken/collection/dict
use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use aiken/interval.{Finite}
use cardano/assets.{AssetName, PolicyId}
use cardano/transaction.{Input, OutputReference, Transaction, ValidityRange}
use nativetokens/utils

/// {"constructor":0,fields[{"int":0},{"int": 1713194931000},{"bytes": "d40e3e791bead1fd8c003f1227906b66a2a1c04e59d663798017db71"},{"int": 50}]}
pub type ConditionsRedeemer {
  action: Action,
  deadline: Int,
  owner: VerificationKeyHash,
  price: Int,
}

/// - 0 -> Owner
/// - 1 -> Time
pub type Action =
  Int

validator ea_nft(unique_utxo: OutputReference, token_name: AssetName) {
  mint(
    redeemer: ConditionsRedeemer,
    policy_id: PolicyId,
    transaction: Transaction,
  ) {
    and {
      utxo_spent(unique_utxo, transaction)?,
      there_can_be_only_one(transaction, policy_id, token_name)?,
      when redeemer.action is {
        // Owner:
        0 -> must_be_signed_by(transaction, redeemer.owner)?

        // Time:
        1 -> must_happen_before(transaction.validity_range, redeemer.deadline)?

        _ -> False
      },
    }
  }

  else(_) {
    fail
  }
}

fn utxo_spent(utxo_ref: OutputReference, tx_info: Transaction) {
  let Transaction { inputs, .. } = tx_info
  inputs |> list.any(fn(input) { input.output_reference == utxo_ref })
}

fn there_can_be_only_one(
  tx_info: Transaction,
  policy_id: PolicyId,
  token_name: AssetName,
) {
  let Transaction { mint, .. } = tx_info
  expect [Pair(asset_name, amount)] =
    mint
      |> assets.tokens(policy_id)
      |> dict.to_pairs()

  and {
    (amount == 1)?,
    (asset_name == token_name)?,
  }
}

fn must_be_signed_by(transaction: Transaction, vk: VerificationKeyHash) {
  transaction.extra_signatories |> list.has(vk)
}

fn must_happen_before(range: ValidityRange, lock_expiration_time: Int) {
  when range.upper_bound.bound_type is {
    Finite(tx_latest_time) -> (lock_expiration_time <= tx_latest_time)?
    _ -> False
  }
}

// ## Tests

test utxo_spent_test() {
  let utxo_ref =
    OutputReference(
      #"0000000000000000000000000000000000000000000000000000000000000000",
      0,
    )
  let tx = utils.dummy_transaction()
  utxo_spent(utxo_ref, tx)?
}
