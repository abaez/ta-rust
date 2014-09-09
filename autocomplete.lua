--- autocomplete for rust.


-- [ctags.rust](https://github.com/rust-lang/rust/blob/master/src/etc/ctags.rust)
return function()
  local list = {}
  local line, pos = buffer:get_cur_line()
  local symbol, op, part = line:sub(1, pos):match(
    "([%w_%d]+)%b<>%s?:[%s*~@&]+%_[^%w_]")

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
  for i = 1, #M.tags do
    if lfs.attributes(M.tags[i]) then
      for line in io.lines(M.tags[i]) do
        local name = line:match('^%S+')
        if name:find(name_patt) and not name:find('^!') and not list[name] then
          local fields = line:match(';"\t(.*)$')
          if (fields:match('class:(%S+)') or fields:match('enum:(%S+)') or
              fields:match('struct:(%S+)') or fields:match('typedef:(%S+)') or
              '') == symbol then
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
