--- autocomplete and api declaration.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module autocomplete

local crates, config = require("modules.rust.config")

local _RUSTSRC = _USERHOME .. '/modules/rust/ta/'

local tags = {}
local api = {}

for _, lib in ipairs(crates) do
  api[#api + 1] = _RUSTSRC .. 'api_' .. lib
  tags[#tags + 1] = _RUSTSRC .. 'tags_' .. lib
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
  local symbol, op, part  line:sub(1, pos):match('([%w_]*)([%.%:]*)([%w_]*)$')
  if symbol == '' and part == '' and op ~= '' then return nil end -- lone ., ->
  if op ~= '' and op ~= '.' and op ~= '::' then return nil end

  -- Search through ctags for completions for that symbol.
  local name_patt = '^'..part
  local sep = string.char(buffer.auto_c_type_separator)
  for i = 1, #tags do
    if lfs.attributes(tags[i]) then
      for line in io.lines(tags[i]) do
        local name = line:match('^%S+')
        if name:find(name_patt) and not name:find('^!') and not list[name] then
          local fields = line:match(';"\t(.*)$')
          if (fields:match('impl') or fields:match('enum') or
              fields:match('struct') or '') == symbol then
            local k = xpms[fields:sub(1, 1)]
            list[#list + 1] = ("%s%s%d"):format(name, sep, xpms[k])
            list[name] = true
          end
        end
      end
    end
  end
  return #part, list
end

return api, autocomplete()
