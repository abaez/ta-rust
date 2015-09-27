--- the module to build user api when building the project.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module api

local function add_apitag(name, path)
  local user_api = path .. "/.api_" .. name
  local user_tag = path .. "/.tag_" .. name

  if io.open(user_api) and io.open(user_tag) then
    table.insert(textadept.editing.api_files.rust, user_api)
    if _M.ctags then
      _M.ctags[path] = user_tag
    end
  end
end

--- builds the api and places in project/.api_projectname.
-- @function build
-- @param project_name the name of the project.
-- @param project_full_path the relative/absolute location of the project.
local function build(project_name, project_full_path, raw)
  local fapi = io.open(project_full_path .. "/.api_" .. project_name, "w")

  for line in io.open(raw):lines() do
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

return {
  build = build,
  add_apitag = add_apitag
}
