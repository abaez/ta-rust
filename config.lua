--- keeps all the user configurations.
-- Modify at your own discretion.

--- all crates as of v1.0.0
-- @table crates
local crates = {
  "alloc",
  "arena",
  "collections",
  "core",
  "debug",
  "flate",
  "fmt_macros",
  "fourcc",
  "getopts",
  "glob",
  "graphviz",
  "green",
  "hexfloat",
  "libc",
  "log",
  "native",
  "num",
  "rand",
  "rbml",
  "regex",
  "regex_macros",
  "rlibc",
  "rustc",
  "rustc_back",
  "rustc_llvm",
  "rustdoc",
  "rustrt",
  "semver",
  "serialize",
  "std",
  "sync",
  "syntax",
  "term",
  "test",
  "time",
  "unicode",
  "url",
  "uuid",
}

local config = {
}


return crates, config
