use aiken/fuzz


type Mydatum {
  mydatum: Int,
}

validator {
  fn datum22(datum: Data, _redeemer: Data, _context: Data) -> Bool {
    expect thedatum: Mydatum = datum
    thedatum.mydatum == 22
  }
}

type MyRedeemer {
  myredeemer: Int,
}

validator {
  fn redeemer11(_datum: Data, redeemer: Data, _context: Data) -> Bool {
    expect theredeemer: MyRedeemer = redeemer
    theredeemer.myredeemer == 11
  }
}

validator {
  fn datumVSredeemer(datum: Data, redeemer: Data, _context: Data) -> Bool {
    redeemer == datum
  }
}


test pbt_numbers(n: Int via fuzz.int()) {
  datumVSredeemer(n,n,"n/a") == True
}
//Must Fail Test
test mf_pbt_n22_to_r11(n: Int via fuzz.int()) {
  datumVSredeemer(n,(n+1),"n/a") == False
}   

//Control Range Test
test pbt_n1000_to_p1000(n via fuzz.list_between(fuzz.int(), -1000, 1000)) {
  datumVSredeemer(n,n,"n/a") == True
}