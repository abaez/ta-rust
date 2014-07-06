#!/usr/bin/lua
--- Makes tags and api for rust

--- all crates as of v0.11
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
  "regex",
  "regex_macros",
  "rlibc",
  "rustc",
  "rustdoc",
  "rustrt",
  "rustuv",
  "semver",
  "serialize",
  "std",
  "sync",
  "syntax",
  "term",
  "test",
  "time",
  "url",
  "uuid",
}

for i, v in ipairs(crates) do
  print(v)
end

local rust_path = "/data/Projects/DVCS/other/git/rust"

ctag_rust = "/src/etc/ctags.rust"


--- converts ctags.rust into correct formatting for use.
-- @function parse_ctags
-- @param f the path of the ctags.rust file.
function parse_ctags(f)
  local ctag_options = ""
  for line in io.input(f):lines("*l") do
    local _, cut = line:find("regex.Rust.")

    if cut then
      ctag_options = string.format("%s  %s'%s'", ctag_options,
        line:sub(1,cut), line:sub(cut+1))
    else
      ctag_options = string.format("%s %s", ctag_options, line)
    end
  end

  return ctag_options
end

local parsed = parse_ctags(rust_path .. ctag_rust)

local out = '| grep -E "^([^_~]|_[^_])" > tags'

os.execute(string.format("ctags %s -R --rust-kinds=-c-d-T %s/src/liburl/*", parsed, rust_path))



function formatter(ctag, mod)
  local fapi = io.open("api_" .. mod, "w")
  local ftag = io.open("tag_" .. mod, "w")

  for line in io.input(ctag):lines("*l") do
      local tline, aline = line, line

    do -- for fapi
      aline = aline:gsub("/.+%prs", "\t")
      aline = aline:gsub("{?$.+", "")
      aline = aline:gsub("/%^", "")
    end

    do -- for ftag
      tline = tline:gsub("/.+%prs", "_")
      tline = tline:gsub("/%^.+\"", "0")
    end

    if line:find("(!_).+") or line:find("^test_") then
      ; -- purposely left blank since no continue
    else
      fapi:write(aline, "\n")
      ftag:write(tline, "\n")
    end
  end

  fapi:close()
  ftag:close()
end

formatter("tags", "test")

os.remove("tags")
return crates
