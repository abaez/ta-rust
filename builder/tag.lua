--- the module to build user tag when building the project.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module tag

--- builds the api and places in project/.tag_projectname.
-- @function build
-- @param project_name see @{api.build}.
-- @param project_full_path see @{api.build}.
local function build(project_name, project_full_path, raw)
  local ftag = io.open(project_full_path .. "/.tag_" .. project_name, "w")

  for line in io.open(raw):lines() do
    local tmpline = line

    tmpline = tmpline:gsub("/%^.+\"", "0")
    if line:find("(!_).+") or line:find("^test_") then
      ; -- purposely left blank to ignore
    else
      ftag:write(tmpline, "\n")
    end
  end

  ftag:close()
end

return {
  build = build
}
