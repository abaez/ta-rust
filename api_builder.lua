--- the module to build user api when building the project.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module build_api

local _CTAGS = _USERHOME .. "/modules/rust/ctags.rust"

--- gets project name. -_-
-- @function get_project_name
-- @return project_name, project_full_path
local function get_project_name()
  local check = io.get_project_root()
  return check and check:gsub("%/.+%/", "") or nil, check
end

--- converts ctags.rust into correct formatting for use.
-- @function parse_ctags
-- @param f the path of the ctags.rust file.
local function parse_ctags(f)
  local ctag_options = ""
  for line in io.input(f):lines("*l") do
    local _, cut = line:find("regex.Rust.")

    if cut then
      ctag_options = string.format("%s  %s'%s'", ctag_options,
        line:sub(1,cut), line:sub(cut+1))
    else
      ctag_options = string.format("%s %s", ctag_options, line)
    end
  end

  return ctag_options
end

--- builds the api and places in project/.api_projectname.
-- @function build_api
-- @param project_name the name of the project.
-- @param project_full_path the relative/absolute location of the project.
local function build_api(project_name, project_full_path)
  local fapi = io.open(project_path .. "/.api_" .. project_name, "w")
  local raw_tag =  io.popen(string.format(
    "ctags -f - %s --languages=Rust -R --rust-kinds=-c-d-T %s/*",
    parse_ctags(_CTAGS),
    project_full_path
  ), 'r')

  for line in raw_tag:lines() do
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
  return raw_tag
end

-- @export get_project_name, build_api
return {
  get_project_name = get_project_name,
  build_api = build_api
}
