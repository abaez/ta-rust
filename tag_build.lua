local parser = require("modules.rust.taparser")

local tags_dir = _USERHOME .. "tags"

function get_project_name()
  return (io.get_project_root()):gsub("%/.+%/", "")
end

function build(project)
  os.execute(string.format("ctags %s -R --rust-kinds=-c-d-T %s -f %s",
    parser.parse_ctags(
      io.open()),
      tags_dir .. "/" .. get_project_name(),
      get_project_name()))
end
