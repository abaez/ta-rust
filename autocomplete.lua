--- autocomplete for rust.

local crates, config = require("modules.rust.config")


local tags = {}
local rust_api = {}
local ta_path = _USERHOME .. '/modules/rust/ta/'

for _, lib in ipairs(crates) do
  table.insert(rust_api, ta_path .. 'api_' .. lib)
  tags[#tags + 1] = ta_path .. 'tags_' .. lib
end

local XPM = textadept.editing.XPM_IMAGES
local xpms = setmetatable({
  c = XPM.VARIABLE, d = XPM.CLASS, f = XPM.METHOD, i = XPM.NAMESPACE,
  g = XPM.TYPEDEF, m = XPM.CLASS,  s = XPM.STRUCT, t = XPM.NAMESPACE,
  T = XPM.TYPEDEF
}, {__index = function(t, k) return 0 end})


-- [ctags.rust](https://github.com/rust-lang/rust/blob/master/src/etc/ctags.rust)
autocomplete = function()
  local list = {}
  local line, pos = buffer:get_cur_line()
  local symbol, op, part = line:sub(1, pos):match(
    "([%w_%d]+)%b<[%w_]+>%s?:[%s%*%&]+[%w_%d]+")

  if symbol == '' and part == '' and op ~= '' then return nil end -- lone ., ->
  if op ~= '' and op ~= '.' and op ~= '::' then return nil end


  local buffer = buffer
  local declaration = "([%w_%d]+)%s?:[%s'*~@&]+%_[^%w_]"

  for i = buffer:line_from_position(buffer.current_pos) - 1, 0, -1 do
    local class = buffer:get_line(i):match(declaration)
    if class then symbol = class break end
  end
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


return rust_api, autocomplete
