--- the module to build user tag when building the project.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module tag

local M = {
  raw
}

--- builds the api and places in project/.tag_projectname.
-- @function build
-- @param project_name see @{api.build}.
-- @param project_full_path see @{api.build}.
function M:build(project_name, project_full_path)
  local ftag = io.open(project_full_path .. "/.tag_" .. project_name, "w")

  for line in self.raw:lines() do
    local tmpline = line

    tmpline = tline:gsub("/%^.+\"", "0")
    if line:find("(!_).+") or line:find("^test_") then
      ; -- purposely left blank to ignore
    else
      ftag:write(tmpline, "\n")
    end
  end

  ftag:close()
end

return M
