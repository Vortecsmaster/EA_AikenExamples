validator typed_datum_22 {
  spend(
    datum: Option<Int>,
    _redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    datum == Some(22)
  }

  else(_) {
    fail
  }
}

validator typed_redeemer_11 {
  spend(
    _datum: Option<Data>,
    redeemer: Int,
    _output_reference: Data,
    _transaction: Data,
  ) {
    redeemer == 11
  }

  else(_) {
    fail
  }
}

validator datum_vs_redeemer {
  spend(
    datum: Option<Int>,
    redeemer: Int,
    _output_reference: Data,
    _transaction: Data,
  ) {
    Some(redeemer) == datum
  }

  else(_) {
    fail
  }
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
    _output_reference: Data,
    _transaction: Data,
  ) {
    expect Some(data) = datum
    data.owd == redeemer.owr
  }

  else(_) {
    fail
  }
}
