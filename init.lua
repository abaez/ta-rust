textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'

-- compiler
textadept.run.compile_commands.rust = 'rustc %(filename)'
textadept.run.run_commands.rust = '%d%(filename_noext)'



local sense = textadept.adeptsense.new('rust')
local as = textadept.adeptsense

-- [ctags.rust](https://github.com/mozilla/rust/blob/master/src/etc/ctags.rust)
-- NOTE: c is disabled in the tags builder. Will change this later on...
sense.ctags_kinds = {
  c = as.FIELD, d = as.CLASS, f = as.FUNCTION, g = as.FIELD, i = as.CLASS,
  m = as.CLASS, s = as.CLASS, t = as.CLASS, T = as.FIELD
}


sense.syntax.class_definition = "(trait)%s+[(%w_)+]"

sense.syntax.type_declarations = {
  "([%w_%d]+)%s?:[%s'*~@&]+%_[^%w_]", -- foo: bar || foo: 'r bar
  "([%w_%d]+)%b<>%s?:[%s*~@&]+%_[^%w_]", -- foo<t>: bar || foo<t>: 'r bar,
}


--sense.syntax.symbol_chars = "[%w_%_]"

-- add a trigger for auto sense
--sense:add_trigger('.')
--sense:add_trigger("::", false, true)
--sense:add_trigger("::")


lib_list = {
    "arena",
    "collections",
    "flate",
    "fourcc",
    "getopts",
    "glob",
    "green",
    "hexfloat",
    "log",
    "native",
    "num",
    "rand",
    "rustc",
    "rustdoc",
    "rustuv",
    "semver",
    "serialize",
    "std",
    "sync",
    "syntax",
    "term",
    "test",
    "time",
    "url",
    "uuid",
    "workcache"
}

ta_path = _USERHOME .. '/modules/rust/ta/'

for _, lib in ipairs(lib_list) do
--  sense.api_files[#sense.apifiles + 1] = ta_path .. 'api_' .. lib_list
  table.insert(sense.api_files, ta_path .. 'api_' .. lib)
  sense:load_ctags(ta_path .. 'tags_' .. lib, true)
end

-- Table of Rust-specific key bindings.
-- @class table
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
    gfn   = "fn %1(name)<%2(T)>(%3(%4(param): &[T])) %5(-> %6(&[T])) {\n\t%0\n}",
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
    ["do"]      = "do |%1(param)| {\n\t%0\n}",
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
    ["print"] = 'print(format!("{:%1(?)}\\n", %0))',

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
  sense = sense
}
