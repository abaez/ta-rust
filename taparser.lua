#!/usr/bin/lua
--- builds the api and tags files for all crates in rust.
-- Completely self contained parser.
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2014
-- @license MIT (see LICENSE)
-- @module taparser


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


local rust_path = "/data/Projects/DVCS/other/git/rust"
local ctag_rust = "/src/etc/ctags.rust"


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


--- builds the api and tags for textadept from parsed ctags.rust file.
-- @function formatter
-- @param crate the library/crate to build.
local function formatter(crate)
  os.execute(string.format("ctags %s -R --rust-kinds=-c-d-T %s/src/lib%s/*",
    parsed, rust_path, crate))

  local fapi = io.open("ta/api_" .. crate, "w")
  local ftag = io.open("ta/tag_" .. crate, "w")

  for line in io.input("tags"):lines("*l") do
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


for _, lib in ipairs(crates) do
  print("building:", lib)
  formatter(lib)
end


os.remove("tags")

return crates
