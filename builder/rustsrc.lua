#!/usr/bin/lua
--- builds the api and tags files for all crates in rust.
-- Completely self contained parser.
-- See @{README.md} for details on usage.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module rustsrc

--- @table crates
-- see {crates} for more info
local crates = require("crates")

local HELP = [[
usage: rustsrc.lua [rust src location]

example:
lua rustsrc.lua /data/Code/src/rust

options:
  -h                        Display this message
  -p  [rust src loc]        rust src location
  -t  [tags.rust loc]       ctags.rust file location
  -c                        Update crates.lua with build
]]

--- converts ctags.rust into correct formatting for use.
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


--- builds the api and tags for textadept from parsed ctags.rust file.
-- @param crate the library/crate to build.
-- @param path the location of your rust source.
-- @param parsed output of parse_ctags.
local function formatter(crate, path, parsed)
  os.execute(string.format("ctags %s -R --rust-kinds=-c-d-T %s/src/lib%s/*",
    parsed, path, crate))

  local fapi = io.open("../ta/api_" .. crate, "w")
  local ftag = io.open("../ta/tag_" .. crate, "w")

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

    if not (line:find("(!_).+") or line:find("^test_")) then
      fapi:write(aline, "\n")
      ftag:write(tline, "\n")
    end
  end

  fapi:close()
  ftag:close()
end

--- initiates the rust src api/tag build.
-- @param t a table containing optional tag and path locations.
function run(t)
  local _USERHOME = os.getenv("HOME") .. "/.textadept"
  local parsed = parse_ctags(t.tag or _USERHOME .. "/modules/rust/ctags.rust")
  local rust_path = t.path or "/data/Code/src/rust"

  for _, lib in ipairs(crates) do
    print("building:", lib)
    formatter(lib, rust_path, parsed)
  end

  os.remove("tags")
end

--- table of parameter actions.
-- see HELP for documentation of each function.
-- @table actions
actions = {
  ["-c"] = function()
    return require("cratesrc")()
  end,

  ["-h"] = function()
    print(HELP)
    os.exit()
  end,

  ["-p"] = function(e)
    return arg[e+1]
  end,

  ["-t"] = function(e)
    return arg[e+1]
  end
}

if arg[1] ~= nil then
  tmp = {}

  for i=1,#arg do
    if arg[i] == "-c" then
      actions[arg[i]]()
    elseif arg[i] == "-h" then
      actions[arg[i]]()
    elseif arg[i] == "-p" then
      tmp.path = actions[arg[i]](i)
    elseif arg[i] == "-t" then
      tmp.tag = actions[arg[i]](i)
    end
  end

  run(tmp)
else
  actions["-h"]()
end
