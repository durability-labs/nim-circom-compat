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


type CircomCompatCtx* {.incompleteStruct.} = object

type Buffer* = object
  data*: pointer
  len*: uint

## # Safety
#
proc init_circom_compat*(r1cs_path: pointer,
                         wasm_path: pointer,
                         zkey_path: pointer,
                         ctx_ptr: ptr ptr CircomCompatCtx): int32 {.importc: "init_circom_compat".}

proc release_circom_compat*(ctx_ptr: ptr ptr CircomCompatCtx): void {.importc: "release_circom_compat".}

proc release_buffer*(buff_ptr: ptr ptr Buffer): void {.importc: "release_buffer".}

## # Safety
#
proc prove_circuit*(ctx_ptr: ptr CircomCompatCtx,
                    compress: bool,
                    proof_bytes_ptr: ptr ptr Buffer,
                    inputs_bytes_ptr: ptr ptr Buffer): int32 {.importc: "prove_circuit".}

## # Safety
#
proc verify_circuit*(ctx_ptr: ptr CircomCompatCtx,
                     compress: bool,
                     proof_bytes_ptr: ptr Buffer,
                     inputs_bytes_ptr: ptr Buffer): int32 {.importc: "verify_circuit".}

## # Safety
#
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
