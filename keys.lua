local api = require("rust.builder.api")
local tag = require("rust.builder.tag")
local raw = require("rust.builder.raw")

return {
   [not OSX and not CURSES and 'cl' or 'ml'] = {
    -- Open this module for editing: `Alt/⌘-L` `M`
    s =
      function() io.open_file(_USERHOME..'/modules/rust/snippets.lua') end
  },

  ['s\n'] = function()
    buffer:line_end()
    buffer:add_text(';')
    buffer:new_line()
  end,

  ['a\n'] = function()
    buffer:line_end()
    buffer:new_line()
    buffer:add_text("/// ");
  end,

  ['cB'] = function()
    local project_name, project_path = raw.get_project_name()

    if project_path then
      local tmp = raw.build(project_path)

      api.build(project_name, project_path, tmp)
      tag.build(project_name, project_path, tmp)
      os.remove(tmp)

      api.add_apitag(project_name, project_path)
    end

    if io.open('../Cargo.toml') ~= nil then
      textadept.run.compile()
      return
    end

    return textadept.run.build()
  end,
}
