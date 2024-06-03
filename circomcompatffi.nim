const ERR_UNKNOWN* = -1

const ERR_OK* = 0

const ERR_WASM_PATH* = 1

const ERR_R1CS_PATH* = 2

const ERR_ZKEY_PATH* = 3

const ERR_INPUT_NAME* = 4

const ERR_INVALID_INPUT* = 5

const ERR_CANT_READ_ZKEY* = 6

const ERR_CIRCOM_BUILDER* = 7

const ERR_FAILED_TO_DESERIALIZE_PROOF* = 8

const ERR_FAILED_TO_DESERIALIZE_INPUTS* = 9

const ERR_FAILED_TO_VERIFY_PROOF* = 10

const ERR_GET_PUB_INPUTS* = 11

const ERR_MAKING_PROOF* = 12

const ERR_SERIALIZE_PROOF* = 13

const ERR_SERIALIZE_INPUTS* = 14


type CircomBn254Cfg* {.incompleteStruct.} = object

type CircomCompatCtx* {.incompleteStruct.} = object

type G1* = object
  x*: array[32, byte]
  y*: array[32, byte]

type G2* = object
  x*: array[2, array[32, byte]]
  y*: array[2, array[32, byte]]

type Proof* = object
  a*: G1
  b*: G2
  c*: G1

type Inputs* = object
  elms*: ptr array[32, byte]
  len*: uint

type VerifyingKey* = object
  alpha1*: G1
  beta2*: G2
  gamma2*: G2
  delta2*: G2
  ic*: ptr G1
  icLen*: uint

proc init_circom_config_with_checks*(r1cs_path: pointer,
                                     wasm_path: pointer,
                                     zkey_path: pointer,
                                     sanity_check: bool,
                                     cfg_ptr: ptr ptr CircomBn254Cfg): int32 {.importc: "init_circom_config_with_checks".}

proc init_circom_config*(r1cs_path: pointer,
                         wasm_path: pointer,
                         zkey_path: pointer,
                         cfg_ptr: ptr ptr CircomBn254Cfg): int32 {.importc: "init_circom_config".}

proc init_circom_compat*(cfg_ptr: ptr CircomBn254Cfg,
                         ctx_ptr: ptr ptr CircomCompatCtx): int32 {.importc: "init_circom_compat".}

proc duplicate_circom_config*(cfg_ptr: ptr CircomBn254Cfg,
                              ctx_ptr: ptr ptr CircomCompatCtx): int32 {.importc: "duplicate_circom_config".}

proc release_circom_compat*(ctx_ptr: ptr ptr CircomCompatCtx): void {.importc: "release_circom_compat".}

proc release_cfg*(cfg_ptr: ptr ptr CircomBn254Cfg): void {.importc: "release_cfg".}

proc release_proof*(proof_ptr: ptr ptr Proof): void {.importc: "release_proof".}

proc release_inputs*(inputs_ptr: ptr ptr Inputs): void {.importc: "release_inputs".}

proc release_key*(key_ptr: ptr ptr VerifyingKey): void {.importc: "release_key".}

proc prove_circuit*(cfg_ptr: ptr CircomBn254Cfg,
                    ctx_ptr: ptr CircomCompatCtx,
                    proof_ptr: ptr ptr Proof): int32 {.importc: "prove_circuit".}

proc get_pub_inputs*(ctx_ptr: ptr CircomCompatCtx,
                     inputs_ptr: ptr ptr Inputs): int32 {.importc: "get_pub_inputs".}

proc get_verifying_key*(cfg_ptr: ptr CircomBn254Cfg,
                        vk_ptr: ptr ptr VerifyingKey): int32 {.importc: "get_verifying_key".}

proc verify_circuit*(proof: ptr Proof,
                     inputs: ptr Inputs,
                     pvk: ptr VerifyingKey): int32 {.importc: "verify_circuit".}

proc push_input_u256_array*(ctx_ptr: ptr CircomCompatCtx,
                            name_ptr: pointer,
                            input_ptr: pointer,
                            len: uint): int32 {.importc: "push_input_u256_array".}

proc push_input_i8*(ctx_ptr: ptr CircomCompatCtx,
                    name_ptr: pointer,
                    input: int8): int32 {.importc: "push_input_i8".}

proc push_input_u8*(ctx_ptr: ptr CircomCompatCtx,
                    name_ptr: pointer,
                    input: uint8): int32 {.importc: "push_input_u8".}

proc push_input_i16*(ctx_ptr: ptr CircomCompatCtx,
                     name_ptr: pointer,
                     input: int16): int32 {.importc: "push_input_i16".}

proc push_input_u16*(ctx_ptr: ptr CircomCompatCtx,
                     name_ptr: pointer,
                     input: uint16): int32 {.importc: "push_input_u16".}

proc push_input_i32*(ctx_ptr: ptr CircomCompatCtx,
                     name_ptr: pointer,
                     input: int32): int32 {.importc: "push_input_i32".}

proc push_input_u32*(ctx_ptr: ptr CircomCompatCtx,
                     name_ptr: pointer,
                     input: uint32): int32 {.importc: "push_input_u32".}

proc push_input_u64*(ctx_ptr: ptr CircomCompatCtx,
                     name_ptr: pointer,
                     input: uint64): int32 {.importc: "push_input_u64".}
