import std/unittest

import ../circomcompat

suite "Test circom compat nim":
  test "Should generate witness, prove and verify":
    let
      r1csPath = "vendor/circom-compat-ffi/fixtures/circom2_multiplier2.r1cs".cstring
      wasmPath = "vendor/circom-compat-ffi/fixtures/circom2_multiplier2.wasm".cstring

    var cfg_ptr: ptr CircomBn254Cfg
    check init_circom_config(
      r1csPath,
      wasmPath,
      nil,
      cfg_ptr.addr) == ERR_OK

    var ctx: ptr CircomCompatCtx
    check init_circom_compat(
      cfg_ptr,
      ctx.addr) == ERR_OK

    check ctx.push_input_i8("a".cstring, 3) == ERR_OK
    check ctx.push_input_i8("b".cstring, 11) == ERR_OK

    var proofPtr: ptr Proof
    var inputsPtr: ptr Inputs
    var vkPtr: ptr VerifyingKey

    check ctx.get_pub_inputs(inputsPtr.addr) == ERR_OK
    check cfg_ptr.prove_circuit(ctx, proofPtr.addr) == ERR_OK

    check cfg_ptr.get_verifying_key(vkPtr.addr) == ERR_OK
    check verify_circuit(proofPtr, inputsPtr, vkPtr) == ERR_OK

    release_proof(proofPtr.addr)
    check proofPtr == nil

    release_inputs(inputsPtr.addr)
    check inputsPtr == nil

    release_key(vkPtr.addr)
    check vkPtr == nil

    ctx.addr.release_circom_compat()
    check ctx == nil
