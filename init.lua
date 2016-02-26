--- the Textadept initializer for the Rust module
-- See @{README.md} for details on usage.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @copyright 2015
-- @license MIT (see LICENSE)
-- @module init


local completer = require("rust.autocomplete")
local api = require("rust.builder.api")
local tag = require("rust.builder.tag")
local raw = require("rust.builder.raw")

textadept.editing.api_files.rust = completer.api_files
textadept.editing.autocompleters.rust = completer.autocomplete

local _keys = require("rust.keys")
local _snippets = require("rust.snippets")

if io.get_project_root() then
  api.add_apitag(raw.get_project_name())
end


textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'
textadept.editing.char_matches.rust = {
  [40] = ')', [91] = ']', [123] = '}', [34] = '"'
}

-- compiler
textadept.run.compile_commands.rust = 'rustc %f'
textadept.run.run_commands.rust = '%d%e'

-- build project
textadept.run.build_commands["Cargo.toml"] = "cargo build"

if type(snippets) == 'table' then
  snippets.rust = _snippets
end

--- Table of Rust-specific key bindings.
keys.rust = _keys

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'rust' then return end

  buffer.tab_width = 4
  buffer.use_tabs = false
  buffer.edge_column = 99
  textadept.editing.STRIP_TRAILING_SPACES = true
end)

local function fmt()
  proc, err = spawn([[rustfmt --write-mode=overwrite ]] .. buffer.filename)
  if not proc then
    error(err)
  end
  proc:wait()
  io.reload_file()
end

-- Rust files are run through `rustfmt` after saving and the text is formatted
-- accordingly. If a syntax error is found it is displayed as an annotation.
events.connect(events.FILE_AFTER_SAVE, function()
  -- enable [rustfmt](https://github.com/rust-lang-nursery/rustfmt)
  if buffer:get_lexer() ~= 'rust' and not _RUSTFMT then return end
  fmt()
end)

return {}
