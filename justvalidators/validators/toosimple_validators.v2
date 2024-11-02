use aiken/fuzz

pub type MyDatum {
  my_datum: Int,
}

validator datum_22 {
  spend(
    datum: Option<MyDatum>,
    _redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    expect Some(the_datum) = datum
    (the_datum.my_datum == 22)?
  }

  else(_) {
    fail
  }
}

pub type MyRedeemer {
  my_redeemer: Int,
}

validator redeemer_11 {
  spend(
    _datum: Option<Data>,
    redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    expect the_redeemer: MyRedeemer = redeemer
    (the_redeemer.my_redeemer == 11)?
  }

  else(_) {
    fail
  }
}

validator datum_vs_redeemer {
  spend(
    datum: Option<Data>,
    redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    (Some(redeemer) == datum)?
  }

  else(_) {
    fail
  }
}

test pbt_numbers(n: Int via fuzz.int()) {
  let datum_n: Data = n
  datum_vs_redeemer.spend(Some(datum_n), n, "n/a", "n/a")?
}

/// Must Fail Test
test mf_pbt_n22_to_r11(n: Int via fuzz.int()) fail {
  let datum_n: Data = n
  datum_vs_redeemer.spend(Some(datum_n), n + 1, "n/a", "n/a")
}

/// Control Range Test
test pbt_n1000_to_p1000(n via fuzz.list_between(fuzz.int(), -1000, 1000)) {
  let datum_n: Data = n
  datum_vs_redeemer.spend(Some(datum_n), n, "n/a", "n/a")
}
