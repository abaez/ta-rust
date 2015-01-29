--- the moduler to builder the raw tags.
-- @author [Alejandro Baez](https:/twitter.com/a_baez)
-- @copyright 2015
-- @licence MIT (see LICENSE)
-- @module raw

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

--- builds raw tag for use with api/tags modules.
-- @param project_full_path see @{api.build}.
local function build(project_full_path)
  return io.popen(string.format(
    "ctags -f - %s --languages=Rust -R --rust-kinds=-c-d-T %s/*",
    parse_ctags(_CTAGS),
    project_full_path
  ), 'r')
end

return {
  build = build,
  get_project_name = get_project_name
}
