--- the moduler to builder the raw tags.
-- @author [Alejandro Baez](https:/twitter.com/a_baez)
-- @copyright 2015
-- @licence MIT (see LICENSE)
-- @module raw

local _CTAGS = _USERHOME .. "/modules/rust/ctags.rust"

--- gets project name from **pwd** or from vcs root.
-- @function get_project_name
-- @return project_name, project_full_path
local function get_project_name()
  local check = io.open("Cargo.toml") ~= nil and
    (buffer.filename or ''):match('^(.+)(%/.+)]') or
    io.get_project_root()
  return check and check:match('^.+%/(%w+)') or nil, check
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
  os.execute(string.format(
    "ctags -f %s %s --languages=Rust -R --rust-kinds=-c-d-T %s/*",
    project_full_path .. "/tags",
    parse_ctags(_CTAGS),
    project_full_path
  ), 'w')

  return project_full_path .. "/tags"
end

return {
  build = build,
  get_project_name = get_project_name
}
