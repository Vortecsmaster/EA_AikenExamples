use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

/// - 0 - Cuenta O
/// - 1 - Cuenta Y
pub type TipoCuenta =
  Int

pub type DatumYO {
  firmante_1: VerificationKeyHash,
  firmante_2: VerificationKeyHash,
  tipo_cuenta: TipoCuenta,
}

validator cuenta_yo {
  spend(
    datum: Option<DatumYO>,
    redeemer: TipoCuenta,
    _utxo: OutputReference,
    tx_info: Transaction,
  ) {
    expect Some(data) = datum
    and {
      (data.tipo_cuenta == redeemer)?,
      cuentas_tipo(data, tx_info)?,
    }
  }

  else(_) {
    fail
  }
}

fn cuentas_tipo(datum: DatumYO, tx_info: Transaction) -> Bool {
  when datum.tipo_cuenta is {
    // Cuenta O:
    0 ->
      comparacion_o(
        datum.firmante_1,
        datum.firmante_2,
        tx_info.extra_signatories,
      )

    // Cuenta Y:
    1 ->
      comparacion_y(
        datum.firmante_1,
        datum.firmante_2,
        tx_info.extra_signatories,
      )

    _ -> False
  }
}

fn comparacion_o(
  firmante_1: VerificationKeyHash,
  firmante_2: VerificationKeyHash,
  firmantes: List<VerificationKeyHash>,
) {
  or {
    buscar_firma(firmante_1, firmantes)?,
    buscar_firma(firmante_2, firmantes)?,
  }
}

fn comparacion_y(
  firmante_1: VerificationKeyHash,
  firmante_2: VerificationKeyHash,
  firmantes: List<VerificationKeyHash>,
) {
  and {
    buscar_firma(firmante_1, firmantes)?,
    buscar_firma(firmante_2, firmantes)?,
  }
}

fn buscar_firma(
  firma: VerificationKeyHash,
  firmas: List<VerificationKeyHash>,
) -> Bool {
  firmas |> list.any(fn(f) { f == firma })
}

test prueba_comparaion_o() {
  comparacion_o("AD81", "BC82", ["AD81", "BC82", "CD35"])?
}

test prueba_comparacion_y() {
  comparacion_y("AD81", "BC82", ["AD81", "BC82", "CD35"])?
}

test prueba_buscar_firma() {
  buscar_firma("AD81", ["AD81", "BC82"])?
}
// test prueba_cuentas_tipo() {
//   cuentas_tipo(0)?
// }
// test prueba_cuenta_yo() {
//   cuenta_yo(
//     DatumYO { firmante_1: "AD81", firmante_2: "AD82", tipo_cuenta: 0 },
//     0,
//     ,
//   )?
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
