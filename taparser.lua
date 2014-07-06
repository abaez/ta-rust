#!/usr/bin/lua
--- Makes tags and api for rust


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

--os.execute(string.format("ctags %s -R --rust-kinds=-c-d-T %s/src/liburl/*", parsed, rust_path))



function api_format(ctag, mod)
  local fw = io.open("api_" .. mod, "w")

  for line in io.input(ctag):lines("*l") do

    line = line:gsub("/.+%prs", "\t")
    line = line:gsub("{?$.+", "")
    line = line:gsub("/%^", "")

    if line:find("(!_).+") or line:find("^test_") then
      ; -- purposely left blank since no continue
    else
      fw:write(line, "\n")
    end
  end

  fw:close()
end

api_format("tags", "test")
