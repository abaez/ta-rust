--- the Textadept initializer for the Rust module
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2014
-- @license MIT (see LICENSE)
-- @module init

textadept.editing.api_files.rust,
textadept.editing.autocompleters.rust = require("modules.rust.autocomplete")

local builder = require("modules.rust.tag_build")

textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'

-- compiler
textadept.run.compile_commands.rust = 'rustc %(filename)'
textadept.run.run_commands.rust = '%d%(filename_noext)'

-- build project
textadept.run.build_commands["Cargo.toml"] = "cargo build"

--- Table of Rust-specific key bindings.
-- @table keys.rust
-- @name _G.keys.rust
keys.rust = {
  [keys.LANGUAGE_MODULE_PREFIX] = {
    m = {io.open_file, _USERHOME..'/modules/rust/init.lua'},
  },
  ['s\n'] = function()
    buffer:line_end()
    buffer:add_text(';')
    buffer:new_line()
  end,

}

if type(snippets) == 'table' then
  snippets.rust = require("modules.rust.snippets")
end

events.connect(events.FILE_AFTER_SAVE, function()
  if buffer:get_lexer() ~= 'rust' then return end

  local proj = builder.get_project_name() or
    ((buffer.filename or ''):match('[^//]+$')):match('[%w_]+')
  local proj_tag = _USERHOME .. "/tags/" .. proj

  if not io.open(proj_tag) then
    builder.build(proj)
  end

  _M.ctags[io.get_project_root()] = proj_tag
end)

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'rust' then return end

  buffer.tab_width = 4
  buffer.use_tabs = false
--  buffer.edge_column = 99
end)

return {}
