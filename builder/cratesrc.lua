--- builds a list of crates in current src stack.
-- @author Alejandro Baez <https://keybase.io/baez>
-- @license MIT (see LICENSE)
-- @copyright 2016
-- @module cratesrc

local header = [[
--- all crates as of v1.8.0
-- @author Alejandro Baez <https://keybase.io/baez>
-- @copyright 2016
-- @license MIT (see LICENSE)
-- @module crates

]]

--- private functions to parse and build the crate list.
-- @table priv
local priv = {

  --- parses the list of crates.
  -- @param cmd a command to use for list aggregate.
  L = function(cmd)
    print("fetching the file,", cmd)
    local tmp = {}
    for line in io.popen(cmd):lines("*l") do
      tmp[#tmp + 1] = line:gsub("^[libc]?lib", "")
    end

    return tmp
  end,

  --- appends to a list a string in lua structure table.
  -- @param list parsed list from @{priv.L}
  Q = function(list)
    local tmp = {}
    for _,v in ipairs(list) do
      tmp[#tmp + 1] = string.format("  %q,\n", v)
    end

    return tmp
  end
}

--- the build operation table
-- @table B
local B = {

  --- constructs the build structure.
  -- @param cmd the command to be parsed by @{priv.L}
  new = function(self, cmd)
    setmetatable(priv, self)
    self.__index = self

    self.Listed = priv.L(cmd)
    self.Quoted = self.Listed ~= nil and
      priv.Q(self.Listed) or
      error("self.Listed not working")

    return priv
  end,

  --- writes to a new lua file a list of crates.
  -- @param name the name of file
  write = function(self, name)
    local f = io.open(name, "w")
    f:write(header)
    f:write("return {\n")

    for _, v in ipairs(self.Quoted) do
      f:write(v)
    end
    f:write("}"):close()

    print("finish writing to:", name)
  end
}

--- the main operator when calling the module.
function main()
  local home = os.getenv("HOME")
  crate = home ~= nil and
    B:new("ls " .. "/data/Code/src/rust" .. "/src | grep lib") or
      error("Couldn't access environment for rust src")
  crate:write("crates.lua")

  print('done')
end

local M = {}
setmetatable(M, {__call = main})

return M
