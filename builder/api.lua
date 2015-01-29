--- the module to build user api when building the project.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module api

local M = {
  raw
}

--- builds the api and places in project/.api_projectname.
-- @function build
-- @param project_name the name of the project.
-- @param project_full_path the relative/absolute location of the project.
local function build(project_name, project_full_path)
  local fapi = io.open(project_full_path .. "/.api_" .. project_name, "w")

  for line in self.raw:lines() do
    local tmpline = line
    tmpline = tmpline:gsub("/.+%prs", "\t")
    tmpline = tmpline:gsub("{?$.+", "")
    tmpline = tmpline:gsub("/%^", "")

    if line:find("(!_).+") or line:find("^test_") then
      ; -- purposely left blank to ignore
    else
      fapi:write(tmpline, "\n")
    end
  end

  fapi:close()
end

return M
