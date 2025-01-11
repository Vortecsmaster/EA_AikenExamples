

// Construct header (0) 0000... address from credentials.
const paymentCredential: Credential = {
    type: "Key",
    hash: "2070f8488dd696b78a5f23e38d273550e43660526c4b19cba733b488"  //taken from cardano-cli generated verification key hash
};

const stakeCredential: Credential = {
      type: "Key",
      hash: "8662fe85a22159022d71aebcf4342bcafaa6ede0df2e486a4e751e8e" // taken from cardano-cli generated stake verification key hash
  };
const bobAddress = credentialToAddress(network, paymentCredential, stakeCredential); // Bob's payment credential and staking credential
console.log("Address11:  " + bobAddress);