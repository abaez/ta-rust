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

--- potentially builds autocomplete using tags.
local function autocomplete()
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

return {
  api_files = api_files,
  autocomplete = autocomplete,
}
