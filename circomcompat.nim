
import std/os
import std/strutils
import std/macros

const
  currentDir = currentSourcePath().parentDir()
  libDir* = currentDir/"vendor/circom-compat-ffi/target"/"release"
  # libDir* = currentDir/"vendor/circom-compat-ffi/target"/"debug" # XXX: uncomment for debug build
  libPath* = libDir/"libcircom_compat_ffi.a"

static:
  let
    cmd = "cargo build --release --manifest-path=vendor/circom-compat-ffi/Cargo.toml"

  warning "\nBuilding circom compat ffi: "
  warning cmd
  let (output, exitCode) = gorgeEx cmd
  if exitCode != 0:
    for ln in output.splitLines():
      warning("rust error> " & ln)
    raiseAssert("Failed to build circom-compat-ffi")
  warning "circom compat ffi built successfully\n"

when defined(windows):
  {.passl: "-lcircom_compat_ffi -lm -lws2_32 -luserenv -lntdll -lbcrypt " & " -L" & libDir.}
else:
  {.passl: "-lcircom_compat_ffi -lm" & " -L" & libDir.}

include circomcompatffi
