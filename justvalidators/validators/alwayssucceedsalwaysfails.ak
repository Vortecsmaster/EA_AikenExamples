validator {
  fn alwaysSucceeds(_datum: Data, _redeemer: Data, _context: Data) -> Bool {
    True
  }
}

validator {
  fn alwaysFails(_datum: Data, _redeemer: Data, _context: Data) -> Bool {
    False
  }
}


test test_numbers() {
  alwaysSucceeds(1, 2, 3) == True && alwaysFails(1, 2, 3) == False
}

test test_bytestrings() {
  alwaysSucceeds("a", "b", "c") == True && alwaysFails("a", "b", "c") == False
}