use aiken/builtin.{i_data, b_data}

validator always_succeeds {
  spend(_datum: Option<Data>, _redeemer: Data, _targe: Data, _context: Data) -> Bool {
    True
  }
}

validator  always_fails {
  spend(_datum: Option<Data>, _redeemer: Data, _targe: Data, _context: Data) -> Bool {
    False
  }
}

test test_numbers() {
  always_succeeds.spend(Some(i_data(1)),2, 3, 4) == True && always_fails.spend(Some(i_data(1)),2, 3, 4) == False
}

test test_bytestrings() {
  always_succeeds.spend(Some(b_data("a")), "b", "c", "d") == True && always_fails.spend(Some(b_data("a")), "b", "c", "d") == False
}