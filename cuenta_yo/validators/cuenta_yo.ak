use aiken/hash.{Blake2b_224, Hash}
use aiken/list.{any}
use aiken/transaction.{ScriptContext, Spend, Transaction}
use aiken/transaction/credential.{VerificationKey}

type PubKeyHash =
  Hash<Blake2b_224, VerificationKey>

type TipoCuenta =
  Int

// 0 - Cuenta O
// 1 - Cuenta Y

type DatumYO {
  firmante_1: PubKeyHash,
  firmante_2: PubKeyHash,
  tipo_cuenta: TipoCuenta,
}

validator {
  fn cuenta_yo(
    datum: DatumYO,
    redeemer: TipoCuenta,
    sContext: ScriptContext,
  ) -> Bool {
    when sContext.purpose is {
      Spend(_) ->
        datum.tipo_cuenta == redeemer && cuentas_tipo(
          datum,
          sContext.transaction,
        )
      _ -> False
    }
  }
}

fn cuentas_tipo(datum: DatumYO, txInfo: Transaction) -> Bool {
  when datum.tipo_cuenta is {
    0 ->
      comparacion_O(
        datum.firmante_1,
        datum.firmante_2,
        txInfo.extra_signatories,
      )
    1 ->
      comparacion_Y(
        datum.firmante_1,
        datum.firmante_2,
        txInfo.extra_signatories,
      )
    _ -> False
  }
}

fn comparacion_O(
  firmante_1: PubKeyHash,
  firmante_2: PubKeyHash,
  firmantes: List<PubKeyHash>,
) {
  buscarFirma(firmante_1, firmantes) || buscarFirma(firmante_2, firmantes)
}

fn comparacion_Y(
  firmante_1: PubKeyHash,
  firmante_2: PubKeyHash,
  firmantes: List<PubKeyHash>,
) {
  buscarFirma(firmante_1, firmantes) && buscarFirma(firmante_2, firmantes)
}

fn buscarFirma(firma: PubKeyHash, firmas: List<PubKeyHash>) -> Bool {
  any(firmas, fn(f) { f == firma })
}

test prueba_comparaion_O() {
  comparacion_O("AD81", "BC82", ["AD81", "BC82", "CD35"])
}

test prueba_comparacion_Y() {
  comparacion_Y("AD81", "BC82", ["AD81", "BC82", "CD35"])
}

test prueba_buscarFirma() {
  buscarFirma("AD81", ["AD81", "BC82"])
}
// test prueba_cuentas_tipo() {
//   cuentas_tipo(0)
// }
// test prueba_cuenta_yo() {
//   cuenta_yo(
//     DatumYO { firmante_1: "AD81", firmante_2: "AD82", tipo_cuenta: 0 },
//     0,
//     ,
//   )
// }
//1. Crear/Escoger carpeta para el proyecto.
//2. Crear nuevo andamiaje del proyecto cmd: aiken new <nombre de tu espacio>/<nombre de tu projecto>
//3. Probar el proyecto cmd: aiken check dentro de la carpeta del proyecto.
//4. Crear primer modulo en carpeta validators en VScode, nombre de modulo minuscula cerrada extensión .ak
//5. Creamos primer modulo cortocircuitado (evalua a True) con datums, redeemer y scontext dummy o Data.
//6. Creamos de nuestro funcion validadora cortocircuitada.
//7. Crear nuestro datum real.
//8. Asignar typu Datum creado a parametro datum del validor.
//9. Corregir la prueba (test) con un valor Datum real.
//10. SCRIPTCONTEXT
//11. Listas y funciones (any)
