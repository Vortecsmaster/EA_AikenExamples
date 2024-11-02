import {Lucid, Blockfrost, Credential, Data, Plutus} from "npm:@lucid-evolution/lucid";
import {applyParamsToScript} from "npm:@lucid-evolution/utils";
import * as CML from "npm:@anastasia-labs/cardano-multiplatform-lib-nodejs";
// import { parseArgs } from "jsr:@std/cli/parse-args";
// import eaNFT from "...ls ." assert { type: "json" };

const validatorFile1: string = Deno.args[0];
const validatorFile2: string = Deno.args[1];

async function getValidator(filePath: string) {
        return JSON.parse(await Deno.readTextFile(filePath));
}

const validator1: any = await getValidator(validatorFile1);
const validator2: any = await getValidator(validatorFile2);

console.log(validatorFile);
console.log(validator);


const signerPkh_1 = CML.toPublicKey();
const signerPkh_2 = CML.toPublicKey(validator2.signer);

console.log(signerPkh_1);
console.log(signerPkh_2);

// const paramsVal = new ConstantSourceNode(0, [signerPkh_1,signerPkh_2"",0])

// const utxoRef = new Constr(0, [,,BigInt(0)]);
        //     new Constr(0, ["d1a52676c0bf8468a1d54fa7c63e18a9a1c89c180c337db16363495c88324f2c"]),
        //     BigInt(1)]);: 

//const paramsEAnftTokenValidator = applyParamsToScript(validator.cborHex, [BigInt(1)]);

//const paramsTokenHolderPolicy = applyParamsToScript(tokenHolderPolicyJSON.cborHex,[utxoRef]);
// const paramsTokenHolderPolicyJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized token holder minting policy.",
//     cborHex: paramsTokenHolderPolicy
// }
// const paramsTokenHolderPolicyLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsTokenHolderPolicy
//   };

// console.log("CREATED!");






// import {generatePrivateKey, generateSeedPhrase, toPublicKey, credentialToAddress } from "npm:@lucid-evolution/utils";
// import {netid} from "./settings.ts";

// import { Blockfrost,
//     C,
//     Data,
//     Lucid,
//     SpendingValidator,
//     TxHash,
//     fromHex,
//     toHex,
//     ,
//     Constr,
//     fromText,
//     WithdrawalValidator} from "https://deno.land/x/lucid@0.10.7/mod.ts";
// import { fromAddressToData, toAddress, contractJSON, writeJson} from "./utilities.ts";
// // import * as cbor from "https://deno.land/x/cbor@v1.4.1/index.js";
// // import * as J from "https://deno.land/x/jsonschema/jsonschema.ts";


// const lucid = await Lucid.new(new Blockfrost("https://cardano-preview.blockfrost.io/api/v0", Deno.env.get("BLOCKFROST_API_KEY"),
//                                             ), "Preview");


// const deadline24h = new Date().getTime() + 86400000   // Based on Slot# 4509190400; //(3600s * 24h) + 86400s/dia
// const deadline10m = new Date().getTime() + 600000; // 10 minutes from now
// const penaltyAddress = fromAddressToData("addr_test1qzt94smqnmsarkpg5wy23pr7d5t4qwk5enfcmu9e73q6j7vsqwmv62r9nltj33vjwezcf9alf8982nlpe9aj3qz9x60q7ht8cm");

// // tokenHolderPolicy
// console.log("Creating parametrized token holder policy...");

// const utxoRef = new Constr(0, [
//     new Constr(0, ["d1a52676c0bf8468a1d54fa7c63e18a9a1c89c180c337db16363495c88324f2c"]),
//     BigInt(1)]);

// const paramsTokenHolderPolicy = applyParamsToScript(tokenHolderPolicyJSON.cborHex,[utxoRef]);
// const paramsTokenHolderPolicyJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized token holder minting policy.",
//     cborHex: paramsTokenHolderPolicy
// }
// const paramsTokenHolderPolicyLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsTokenHolderPolicy
//   };

// console.log("CREATED!");

// //Discovery Policy
// console.log("Creating parametrized discovery minting policy...");

// const initDiscoveryPolicyParams = new Constr(0, [
//     new Constr(0, [new Constr(0, ["4fb451485056a49b61f65dcc405fcdd2ccb5b9437c073e2ad340b56e09030986"]),
//                                   BigInt(3)]), // treasury UTxO
//                    BigInt(deadline24h), // discoveryDeadline PInteger
//                    penaltyAddress.data, // penaltyAddress PAddress
//   ]);

// const paramsDiscoveryPolicy = applyParamsToScript(discoveryPolicyJSON.cborHex, [initDiscoveryPolicyParams]);
// const paramsDiscoveryPolicyJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized discovery minting policy.",
//     cborHex: paramsDiscoveryPolicy
// }
// const paramsDiscoveryPolicyLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsDiscoveryPolicy
//   };

// console.log("CREATED!");

// // Fold Validator
// console.log("Creating parametrized fold validator...");

// // const foldValidatorParams = [lucid.utils.mintingPolicyToId(discoveryMintingPolicy), BigInt(config.discoveryPolicy.deadline)];

// const paramsFoldValidator = applyParamsToScript(foldValidatorJSON.cborHex, [ lucid.utils.mintingPolicyToId(paramsDiscoveryPolicyLucid),
//   BigInt(deadline24h)]);

// const paramsFoldValidatorJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized fold validator.",
//     cborHex: paramsFoldValidator
// }
// const paramsFoldValidatorLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsFoldValidator
//   };

// console.log("CREATED!"); 


// // Fold Minting Policy
// console.log("Creating parametrized fold minting policy...");

// const foldValidatorAddress = fromAddressToData(lucid.utils.validatorToAddress(paramsFoldValidatorLucid));

// const foldMintingPolicyParams = new Constr(0, [
//     lucid.utils.mintingPolicyToId(paramsDiscoveryPolicyLucid),
//     foldValidatorAddress.data,
//     BigInt(deadline24h) // discoveryDeadline PInteger
//   ]);
// const utxoRef = new Constr(0, [
        //     new Constr(0, ["d1a52676c0bf8468a1d54fa7c63e18a9a1c89c180c337db16363495c88324f2c"]),
        //     BigInt(1)]);
// const paramsFoldMintingPolicy = applyParamsToScript(foldPolicyJSON.cborHex, [foldMintingPolicyParams]);

// const paramsFoldMintingPolicyJSON = {
//     type: "PlutusV2",
//     description: "The parametrized fold minting policy.",
//     cborHex: paramsFoldMintingPolicy
// }
// const paramsFoldMintingPolicyLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsFoldMintingPolicy
//   };

// console.log("CREATED!");


// //Reward Fold Validator
// console.log("Creating parametrized reward fold validator...");

// const projectAddressData = fromAddressToData(_PROJECT_ADDR_)

// const rewardFoldValidatorParams: Data = new Constr(0, [
//     lucid.utils.mintingPolicyToId(paramsDiscoveryPolicyLucid), // nodeCS
//     _PROJECT_CS_, // projectCS
//     fromText("PBTTokenName"), // projectTN
//     projectAddressData.data  // projectAddr
//     ]);

// const paramsRewardFoldValidator = applyParamsToScript(rewardFoldValidatorJSON.cborHex, [rewardFoldValidatorParams]);

// const paramsRewardFoldValidatorLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsRewardFoldValidator
//   };
// const paramsRewardFoldValidatorJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized reward fold validator.",
//     cborHex: paramsRewardFoldValidator
// }
// console.log("CREATED!");


// // Reward Fold Minting Policy
// console.log("Creating parametrized reward fold minting policy...");

// const rewardFoldValidatorAddress = fromAddressToData(lucid.utils.validatorToAddress(paramsRewardFoldValidatorLucid));

// const initRewardPolicyParams = new Constr(0, [
//     lucid.utils.mintingPolicyToId(paramsDiscoveryPolicyLucid), // nodeCS
//     lucid.utils.mintingPolicyToId(paramsTokenHolderPolicyLucid), //tokenHolderCS
//     rewardFoldValidatorAddress.data, // rewardScriptAddr
//     fromText("DiscoveryTokenName"), // projectTN
//     _PROJECT_CS_, // projectCS
//     lucid.utils.mintingPolicyToId(paramsFoldMintingPolicyLucid) // commitFoldCS  -> foldMint
//     ]);
// const paramsRewardFoldMintPolicy = applyParamsToScript(rewardFoldMintPolicyJSON.cborHex, [initRewardPolicyParams]);
// const paramsRewardFoldMintPolicyLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsRewardFoldMintPolicy
//   };
// const paramsRewardFoldMintPolicyJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized reward fold minting policy.",
//     cborHex: paramsRewardFoldMintPolicy
// }  
// console.log("CREATED!");

// // Token Holder Validator
// console.log("Creating parametrized token holder validator...");


// const paramsTokenHolderValidator = applyParamsToScript(tokenHolderValidator.cborHex, [lucid.utils.mintingPolicyToId(paramsRewardFoldMintPolicyLucid)]);
// const paramsTokenHolderValidatorJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized token holder validator.",
//     cborHex: paramsTokenHolderValidator
// }
// const _paramsTokenHolderValidatorLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsTokenHolderValidator
//   };


// console.log("CREATED!");



// // Discovery Stake Validator
// console.log("Creating parametrized discovery stake validator...");

// const initDiscoveryStakeValParams = lucid.utils.mintingPolicyToId(paramsRewardFoldMintPolicyLucid);

// const paramsDiscoveryStakeValidator = applyParamsToScript(discoveryStakeValidatorJSON.cborHex, [initDiscoveryStakeValParams]); 
// const paramsDiscoveryStakeValidatorLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsDiscoveryStakeValidator //discoveryStakeValidatorJSON.cborHex,
//   };
// console.log("CREATED!");


// //Discovery Validator
// console.log("Creating parametrized discovery validator...");

// const initDiscoveryParams =  new Constr(0, [
//     BigInt(deadline24h), // discoveryDeadline PInteger
//     penaltyAddress.data, // penaltyAddress PAddress
//     new Constr(0, [new Constr(1, [lucid.utils.validatorToScriptHash(paramsDiscoveryStakeValidatorLucid)])]), // PStakingCredential
//   ])

// const paramsDiscoveryValidator = applyParamsToScript(discoveryValidatorJSON.cborHex, [initDiscoveryParams]);
// const paramsDiscoveryValidatorJSON: contractJSON = {
//     type: "PlutusV2",
//     description: "The parametrized discovery validator.",
//     cborHex: paramsDiscoveryValidator
// }
// const paramsDiscoveryValidatorLucid: WithdrawalValidator = {
//     type: "PlutusV2",
//     script: paramsDiscoveryValidator
//   };

// console.log("CREATED!");


// console.log("Creating JSON encoded CBOR hex files for Cardano CLI...");

// //writeJson("demo.json", discoveryMinting);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsTokenHolderPolicy.json", paramsTokenHolderPolicyJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsTokenHolderPolicy.pid", lucid.utils.mintingPolicyToId(paramsTokenHolderPolicyLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsDiscoveryPolicy.json", paramsDiscoveryPolicyJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsDiscoveryPolicy.pid", lucid.utils.mintingPolicyToId(paramsDiscoveryPolicyLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsFoldValidator.json", paramsFoldValidatorJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsFoldValidator.addr", lucid.utils.validatorToAddress(paramsFoldValidatorLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsFoldMintingPolicy.json", paramsFoldMintingPolicyJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsFoldMintingPolicy.pid", lucid.utils.mintingPolicyToId(paramsFoldMintingPolicyLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsRewardFoldValidator.json", paramsRewardFoldValidatorJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsRewardFoldValidator.addr", lucid.utils.validatorToAddress(paramsRewardFoldValidatorLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsRewardFoldMintPolicy.json", paramsRewardFoldMintPolicyJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsRewardFoldMintPolicy.pid", lucid.utils.mintingPolicyToId(paramsRewardFoldMintPolicyLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsTokenHolderValidator.json", paramsTokenHolderValidatorJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsTokenHolderValidator.addr", lucid.utils.validatorToAddress(_paramsTokenHolderValidatorLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsDiscoveryStakeValidator.json", paramsDiscoveryStakeValidatorLucid);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsDiscoveryStakeValidator.addr", lucid.utils.validatorToAddress(paramsDiscoveryStakeValidatorLucid));
// writeJson("../../DiscoveryCompiled/Parametrized/paramsDiscoveryValidator.json", paramsDiscoveryValidatorJSON);
// writeJson("../../DiscoveryCompiled/Parametrized/paramsDiscoveryValidator.addr", lucid.utils.validatorToAddress(paramsDiscoveryValidatorLucid));
// console.log("CREATED!");
// console.log("DONE!");	