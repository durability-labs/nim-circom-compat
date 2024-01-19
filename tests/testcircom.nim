import std/unittest

import ../circomcompat

suite "Test circom compat nim":
  test "Should generate witness, prove and verify":
    let
      r1csPath = "vendor/circom-compat-ffi/fixtures/mycircuit.r1cs".cstring
      wasmPath = "vendor/circom-compat-ffi/fixtures/mycircuit.wasm".cstring

    var ctx: ptr CircomCompatCtx
    let res = init_circom_compat(
      r1csPath,
      wasmPath,
      nil,
      ctx.addr)

    check ctx.push_input_numeric_i8("a".cstring, 3) == ERR_OK
    check ctx.push_input_numeric_i8("b".cstring, 11) == ERR_OK

    var proofBytes: ptr Buffer
    var publicBytes: ptr Buffer

    check ctx.prove_circuit(proofBytes.addr, publicBytes.addr) == ERR_OK

    check proofBytes.len > 0
    check publicBytes.len > 0

    check ctx.verify_circuit(proofBytes, publicBytes) == ERR_OK

    ctx.addr.release_circom_compat()
    check ctx == nil

    proofBytes.addr.release_buffer()
    check proofBytes == nil

    publicBytes.addr.release_buffer()
    check publicBytes == nil

    check res == ERR_OK
