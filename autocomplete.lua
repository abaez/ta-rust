--- autocomplete and api declaration.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module autocomplete

local crates = require("rust.builder.crates")

local _RUST = _USERHOME .. '/modules/rust/ta/'
local _RUSTSRC = "/data/Code/rust/src"

local tag_files = {}
local api_files = {}

for _, lib in ipairs(crates) do
  api_files[#api_files + 1] = _RUST .. 'api_' .. lib
  tag_files[#tag_files + 1] = _RUST .. 'tag_' .. lib
end

local XPM = textadept.editing.XPM_IMAGES
local xpms = setmetatable({
  c = XPM.VARIABLE, d = XPM.CLASS, f = XPM.METHOD, i = XPM.NAMESPACE,
  g = XPM.TYPEDEF, m = XPM.CLASS,  s = XPM.STRUCT, t = XPM.NAMESPACE,
  T = XPM.TYPEDEF
}, {__index = function(t, k) return 0 end})

local auto = {}

--- potentially builds autocomplete using tags.
function auto.ctags()
  local list = {}

  -- symbol behind caret
  local line, pos = buffer:get_cur_line()
  local part = line:sub(1, pos):match('([%w_]*)$')
  if part == '' then return nil end -- nothing to match against

  -- Search through ctags for completions for that symbol.
  local name_patt = '^'..part
  local sep = string.char(buffer.auto_c_type_separator)
  for i = 1, #tag_files do
    if lfs.attributes(tag_files[i]) then
      for line in io.lines(tag_files[i]) do
        local name = line:match('^%S+')
        if name:find(name_patt) and not name:find('^!') and not list[name] then
          local k = line:match('\t(%a)$')
          if k then
            list[#list + 1] = ("%s%s%d"):format(name, sep, xpms[k])
            list[name] = true
          end
        end
      end
    end
  end
  return #part, list
end

--- potential autocomplete with racer
function auto.racer()
  local list = {}

  -- symbol behind caret
  local line, pos = buffer:get_cur_line()
  local part = line:sub(1, pos):match("([%w_]*)$")
  if part == '' then return nil end -- nothing to match against

  -- run racer and error check
  local num  = buffer:line_from_position(buffer.current_pos) + 1
  local cmd = ("racer complete-with-snippet %d %d %s"):format(
    num,
    pos, buffer.filename)
  local proc, err = spawn(cmd)
  if err ~= nil then
    error(err)
    return nil -- nothing to match
  end

  -- search through results for completions of symbol
  local name_patt = '^' .. part
  local sep = string.char(buffer.auto_c_type_separator)

  local res = proc:read()
  while res ~= nil do
    if res:match("MATCH") then
      local name = res:match("([%w_]+)(%p)")

      if not list[name] or name:match(name_patt) then
        local _, k = res:match("(%prs%p)([%w_]+)(%p)")
        list[#list + 1] = ("%s%s%d"):format(name, sep, xpms["c"])
        list[name] = true
      end
    end
    res = proc:read()
  end

  proc:wait()
  return #part, list
end

return {
  api_files = api_files,
  auto = auto,
}
