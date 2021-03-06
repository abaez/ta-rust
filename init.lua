--- the Textadept initializer for the Rust module
-- See @{README.md} for details on usage.
-- @author [Alejandro Baez](https://keybase.io/baez)
-- @copyright 2014-2016
-- @license MIT (see LICENSE)
-- @module init

local api = require("rust.builder.api")
local tag = require("rust.builder.tag")
local raw = require("rust.builder.raw")
local completer = require("rust.autocomplete")
local _keys = require("rust.keys")
local _snippets = require("rust.snippets")

textadept.editing.api_files.rust = completer.api_files
textadept.editing.autocompleters.rust = _RACER and
  completer.auto.racer or completer.auto.ctags


if raw.get_project_name() then
  api.add_apitag(raw.get_project_name())
end


textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'

-- compiler
textadept.run.compile_commands.rust = 'cargo build'
textadept.run.run_commands.rust = 'cargo run'

-- build project
textadept.run.build_commands["Cargo.toml"] = "cargo build"

if type(snippets) == 'table' then
  snippets.rust = _snippets
end

--- Table of Rust-specific key bindings.
keys.rust = _keys

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'rust' then
    textadept.editing.auto_pairs[39] = "'" -- re-enable single quote
    return
  end

  textadept.editing.auto_pairs[39] = nil -- single quote
  buffer.tab_width = 4
  buffer.use_tabs = false
  buffer.edge_column = 99
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
  if buffer:get_lexer() ~= 'rust' or not _RUSTFMT then return end
  fmt()
end)

return {}
