#!/usr/bin/env lua

local header = [[
--- all crates as of v1.8.0
-- @author Alejandro Baez <https://keybase.io/baez>
-- @copyright 2016
-- @license MIT (see LICENSE)
-- @module crates

]]

local priv = {
  L = function(str)
    print("fetching the file,", str)
    local tmp = {}
    for line in io.popen(str):lines("*l") do
      tmp[#tmp + 1] = line:gsub("^[libc]?lib", "")
    end

    return tmp
  end,
  Q = function(list)
    local tmp = {}
    for _,v in ipairs(list) do
      tmp[#tmp + 1] = string.format("  %q,\n", v)
    end

    return tmp
  end
}

local B = {
  new = function(self, str)
    setmetatable(priv, self)
    self.__index = self

    self.Listed = priv.L(str)
    self.Quoted = self.Listed ~= nil and
      priv.Q(self.Listed) or
      error("self.Listed not working")

    return priv
  end,

  write = function(self, str)
    local f = io.open(str, "w")
    f:write(header)
    f:write("return {\n")

    for _, v in ipairs(self.Quoted) do
      f:write(v)
    end
    f:write("}"):close()

    print("finish writing to:", str)
  end
}


local home = os.getenv("HOME")
crate = home ~= nil and
  B:new("ls /data/Code/src/rust/src | grep lib") or
    error("Couldn't access environment for rust src")
crate:write("crates.lua")

print('done')

