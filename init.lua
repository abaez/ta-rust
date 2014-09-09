--- the Textadept initializer for the Rust module
-- See @{README.md} for details on usage.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2014
-- @license MIT (see LICENSE)
-- @module rust

local crates, config = require("modules.rust.config")
textadept.editing.autocompleters.rust = require("modules.rust.autocomplete")

textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'

-- compiler
textadept.run.compile_commands.rust = 'rustc %(filename)'
textadept.run.run_commands.rust = '%d%(filename_noext)'


local XPM = textadept.editing.XPM_IMAGES
local xpms = setmetatable({
  c = XPM.VARIABLE, d = XPM.CLASS, f = XPM.METHOD, i = XPM.NAMESPACE,
  g = XPM.TYPEDEF, m = XPM.CLASS,  s = XPM.STRUCT, t = XPM.NAMESPACE,
  T = XPM.TYPEDEF
}, {__index = function(t, k) return 0 end})


local tags = {}
local rust_api = {}

ta_path = _USERHOME .. '/modules/rust/ta/'

for _, lib in ipairs(crates) do
  table.insert(rust_api, ta_path .. 'api_' .. lib)
  tags[#tags + 1] = ta_path .. 'tags_' .. lib
end

textadept.editing.api_files.rust = rust_api

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
  snippets.rust = {

    -- functions
    fn    = "fn %1(name)(%2(&self)) %3(-> %4(type) ){\n\t%0\n}",
    gfn   = "fn %1(name)<%2(T)>(%3(%4(param): %2)) %5(-> %6(%2)) {\n\t%0\n}",
    divfn = "fn %1(name)(%2(param)) ! {\n\t%0\n}",

    -- closures
    s     = "|%1(param)| %0", -- stack closure
    o     = "proc() {\n\t%0\n}", -- owned closure


    -- Items and Attributes
    extern  = "extern %1(\"ABI\") {\n\t%0\n}",
    struct  = "struct %1(name) {\n\t%0\n}",
    enum    = "enum %1(name) {\n\t%0\n}",
    mod     = "mod %1(name) {\n\t%0\n}",
    trait   = "trait %1(name) {\n\t%0\n}",
    impl    = "impl %1(name) %2(for %3(type)){\n\t%0\n}",

    -- Expressions
    v           = "[%1(start), %2(.. %3(range_end))]%0",
    ["while"]   = "while %1(expr) {\n\t%0\n}",
    loop        = "loop {\n\t%0\n}",
    ["for"]     = "for %1(i) in %2(iterator) {\n\t%0\n}",
    ["forr"]     = "for %1(i) in range(%2(0), %3(10)) {\n\t%0\n}",

    -- if
    ["if"]      = "if %1(expr) {\n\t%2\n} %0",
    ["else"]    = 'else {\n\t%0\n}',
    match       = "match %1(expr) {\n\t%2(pattern) => %3(expr)\n}",

    -- random
    ["#"]   = "#[%1(attribute)]",
    static  = "static %1(name): %2(type) = %0;",
    lmut    = "let mut %1(name): %2(type) = %0;",
    let     = "let %1(name): %2(type) = %0;",
    ["/*"]  = "/*\n\t%0\n*/",
    ["print"] = 'println!("{:%1(?)}\\n", %0);',

    -- tasks and communication
    ["spawn"] = "spawn(proc() {\n\t%0\n});",
    ["channel"] = "let (%1(tx, rx)): (Sender<%2(int)>, Receiver<%3(int)) = channel();%0",

  }
end


events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'rust' then return end

  buffer.tab_width = 4
  buffer.use_tabs = false
end)

return {
  tags = tags
}
