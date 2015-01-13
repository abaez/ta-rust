local _CTAGS = _USERHOME .. "/modules/rust/ctags.rust"


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

function build(project)
  fw = io.open(io.get_project_root() .. "." .. project, "w")

  for line in io.popen(string.format(
    "ctags -f - %s -R --rust-kinds=-c-d-T %s/*",
    parse_ctags(_CTAGS),
    io.get_project_root()
  ), 'r'):lines() do

  end
end
