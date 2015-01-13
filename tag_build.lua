local parser = require("modules.rust.taparser")

local tags_dir = _USERHOME .. "/tags"

local function get_project_name()
  local check = io.get_project_root()
  return check and (check):gsub("%/.+%/", "") or nil
end

local function build(project)
  os.execute(string.format(
    "ctags -f %s %s -R --rust-kinds=-c-d-T %s/*",
    tags_dir .. "/" .. project,
    parser.parse_ctags(_USERHOME .. "/modules/rust/ctags.rust"),
    io.get_project_root())
  )
end

return {
  build = build,
  get_project_name = get_project_name
}
