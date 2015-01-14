--- the module to build user tag when building the project.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module tag

local function build_tags(project_name, project_path, raw_tag)
  local ftag = io.open(project_path .. "/.tag_" .. project_name, "w")

  for line in raw_tag:lines() do
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

-- @export build_tags
return {
  build_tags = build_tags
}
