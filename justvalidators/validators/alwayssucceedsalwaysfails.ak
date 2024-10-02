validator always_succeeds {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    True
  }

  else(_) {
    fail
  }
}

validator always_fails {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    False
  }

  else(_) {
    fail
  }
}

test test_numbers() {
  let datum_1: Data = 1
  and {
    always_succeeds.spend(Some(datum_1), 2, 3, 4)?,
    !always_fails.spend(Some(datum_1), 2, 3, 4)?,
  }
}

test test_bytestrings() {
  let datum_a: Data = "a"
  and {
    always_succeeds.spend(Some(datum_a), "b", "c", "d")?,
    !always_fails.spend(Some(datum_a), "b", "c", "d")?,
  }
}
