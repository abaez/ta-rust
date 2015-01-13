local parser = require("modules.rust.taparser")

local tags_dir = _USERHOME .. "tags"

local function get_project_name()
  return (io.get_project_root()):gsub("%/.+%/", "")
end

local function build(project)
  os.execute(string.format("ctags %s -R --rust-kinds=-c-d-T %s -f %s",
    parser.parse_ctags(_USERHOME .. "/modules/rust/ctags.rust"),
    tags_dir .. "/" .. project,
    project))
end

return {
  build = build
}
