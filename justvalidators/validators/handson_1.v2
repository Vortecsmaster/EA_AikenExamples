type MyRedeemer {
  red: Int,
}

validator handson_no_1 {
  spend(
    datum: Option<Data>,
    redeemer: Data,
    _output_reference: Data,
    _transaction: Data,
  ) {
    if (datum == Some(redeemer))? {
      True
    } else {
      expect the_redeemer: MyRedeemer = redeemer
      (the_redeemer.red == 11)?
    }
  }

  else(_) {
    fail
  }
}

pub type MyType {
  Unit
  Number { x: Int }
  YesNo { yn: Bool }
}

validator hands_no_1_r {
  spend(
    datum: Option<MyType>,
    redeemer: MyType,
    _output_reference: Data,
    _transaction: Data,
  ) {
    when (datum, redeemer) is {
      (Some(Number(dat1)), Number(red2)) -> (dat1 == red2)?
      (Some(YesNo(dat1)), YesNo(red2)) -> (dat1 == red2)?
      (Some(Unit), Unit) -> True

      // this means: allow spending as long as the redeemer is 11, regardless whether a datum exists or not
      (_, Number(red2)) -> (red2 == 11)?

      _ -> False
    }
  }

  else(_) {
    fail
  }
}
