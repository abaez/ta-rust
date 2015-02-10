--- the Textadept initializer for the Rust module
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2014
-- @license MIT (see LICENSE)
-- @module init


textadept.editing.api_files.rust,
textadept.editing.autocompleters.rust = require("rust.autocomplete")
local api = require("rust.builder.api")
local tag = require("rust.builder.tag")
local raw = require("rust.builder.raw")


local function add_apitag(name, path)
  local user_api = path .. "/.api_" .. name
  local user_tag = path .. "/.tag_" .. name

  if io.open(user_api) and io.open(user_tag) then
    table.insert(textadept.editing.api_files.rust, user_api)
    _M.ctags[path] = user_tag
  end
end

if io.get_project_root() then
  add_apitag(raw.get_project_name())
end


textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'
textadept.editing.char_matches.rust = {
  [40] = ')', [91] = ']', [123] = '}', [34] = '"'
}

-- compiler
textadept.run.compile_commands.rust = 'rustc %(filename)'
textadept.run.run_commands.rust = '%d%(filename_noext)'

-- build project
textadept.run.build_commands["Cargo.toml"] = "cargo build"


if type(snippets) == 'table' then
  snippets.rust = require("modules.rust.snippets")
end

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'rust' then return end

  buffer.tab_width = 4
  buffer.use_tabs = false
--  buffer.edge_column = 99


  --- Table of Rust-specific key bindings.
  keys['s\n'] = function()
    buffer:line_end()
    buffer:add_text(';')
    buffer:new_line()
  end
  keys['cB'] = function()
    local project_name, project_path = raw.get_project_name()

    if project_path then
      local tmp = raw.build(project_path)

      api.build(project_name, project_path, tmp)
      tag.build(project_name, project_path, tmp)
      os.remove(tmp)

      add_apitag(project_name, project_path)
    end

    return textadept.run.build()
  end
end)

return {}
