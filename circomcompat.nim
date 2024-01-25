
import std/os
import std/strutils
import std/macros

const
  currentDir = currentSourcePath().parentDir()
  libDir* = currentDir/"vendor/circom-compat-ffi/target"/"release"
  # libDir* = currentDir/"vendor/circom-compat-ffi/target"/"debug" # XXX: uncomment for debug build
  libPath* = libDir/"libcircom_compat_ffi.a"

static:
  let cmd = "cd vendor/circom-compat-ffi && cargo build --release"
  warning "\nBuilding circom compat ffi: " & cmd
  let (output, exitCode) = gorgeEx cmd
  for ln in output.splitLines():
    warning("cargo> " & ln)
  if exitCode != 0:
    raiseAssert("Failed to build circom-compat-ffi")

{.passl: "-lcircom_compat_ffi -lm" & " -L" & libDir.}

include circomcompatffi
