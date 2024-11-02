import {generatePrivateKey, generateSeedPhrase, toPublicKey, credentialToAddress } from "npm:@lucid-evolution/utils";
import {Lucid, Blockfrost, Credential} from "npm:@lucid-evolution/lucid";
import * as CML from "npm:@anastasia-labs/cardano-multiplatform-lib-nodejs";
import {netid} from "./settings.ts";


const user1 = await Lucid(new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", Deno.env.get("BLOCKFROST_PROJECT_ID"),),netid);
const user2 = await Lucid(new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", Deno.env.get("BLOCKFROST_PROJECT_ID"),),netid);

const user1pk = await Deno.readTextFile("../../../../Wallets/Charlie.prk");

user1.selectWallet.fromPrivateKey(user1pk);
const address01 = await user1.wallet().address();

// console.log("User 1");
// console.log(user1pk);
// console.log(address01);


const utxos = await user1.utxosAt(address01);

console.log(utxos);