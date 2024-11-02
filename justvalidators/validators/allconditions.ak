use aiken/crypto.{VerificationKeyHash}
use aiken/interval.{Finite, before}
use aiken/collection/list
use aiken/collection/dict
use cardano/transaction.{Transaction, ValidityRange, OutputReference}
use cardano/assets.{zero}

pub type ConditionsDatum {
  deadline: POSIXtime,
  owner: VerificationKeyHash,
  price: Int,
}

type POSIXtime =
  Int

validator all_conditions() {
  spend(datum: Option<ConditionsDatum>, _redeemer: Int, _utxo_ref: OutputReference, tx_info: Transaction) {
    expect Some(datum) = datum
    and{must_be_signed_by(tx_info.extra_signatories, datum.owner),
        must_happen_before(tx_info.validity_range, datum.deadline),
        price_is_covered(tx_info, datum.price)
       }
  }
}

fn must_be_signed_by(signatories: List<VerificationKeyHash>, signer: VerificationKeyHash) {
  list.has(signatories, signer)
}

fn must_happen_before(range: ValidityRange, lock_expiration_time: POSIXtime) {
  when range.upper_bound.bound_type is {
    Finite(tx_latest_time) -> lock_expiration_time >= tx_latest_time
    _ -> False
  }
}

fn price_is_covered(tx_info: Transaction, price: Int) {
  True
}

test all_conditions_fullfilled() {
  
   let dat = ConditionsDatum {
      deadline: 999999999,
      owner:  "1234567890abcdef",
      price: 50 
   }
      
   let tx_info = Transaction {
                 inputs: [],
       reference_inputs: [],
                outputs: [],
                    fee: 0,
                   mint: zero,
           certificates: [],
            withdrawals: [],
         validity_range: before(999999998),
      extra_signatories: ["1234567890abcdef"],
              redeemers: [],
                 datums: dict.empty,
                     id: "",
                  votes: [],
    proposal_procedures: [],
    current_treasury_amount: None,
    treasury_donation: None
      }


    let dummy_utxo_ref = OutputReference { transaction_id: "", output_index: 0 } 

    all_conditions.spend(Some(dat), 0, dummy_utxo_ref ,tx_info)
}
