import {generatePrivateKey, generateSeedPhrase, toPublicKey, credentialToAddress } from "npm:@lucid-evolution/utils";
import {Lucid, Blockfrost, Credential} from "npm:@lucid-evolution/lucid";
import * as CML from "npm:@anastasia-labs/cardano-multiplatform-lib-nodejs";
import {netid} from "../settings.ts";


const user1 = await Lucid(new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", Deno.env.get("BLOCKFROST_PROJECT_ID"),),netid);
const user2 = await Lucid(new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", Deno.env.get("BLOCKFROST_PROJECT_ID"),),netid);


// Generate a new private key
const privateKey01 = generatePrivateKey();
const publicKey01 = toPublicKey(privateKey01);
user1.selectWallet.fromPrivateKey(privateKey01)
const address01 = await user1.wallet().address();

// Generate a private key out of a seed phrase
const seedPhrase02 = generateSeedPhrase();
const privateKey02 = generatePrivateKey(seedPhrase02);
const publicKey02 = toPublicKey(privateKey02);

user2.selectWallet.fromSeed(seedPhrase02);

const address02 = await user2.wallet().address();

console.log("Generando llaves...");
Deno.writeTextFile("../../../../Wallets/Charlie2.pk", privateKey01);
Deno.writeTextFile("../../../../Wallets/Charlie2.addr", address01);
Deno.writeTextFile("../../../../Wallets/David2.pk", privateKey02);
Deno.writeTextFile("../../../../Wallets/David2.addr", address02);


console.log("User 1");
console.log(privateKey01);
console.log(publicKey01);
console.log(address01);
console.log("----------------");
console.log("User 2"); 
console.log(seedPhrase02);
console.log(privateKey02);
console.log(publicKey02);
console.log(address02);
