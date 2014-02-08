textadept.file_types.extensions.rs = 'rust'
textadept.editing.comment_string.rust = '//'

-- compiler
textadept.run.compile_commands.rust = 'rustc %(filename)'


local sense = textadept.adeptsense.new('rust')
local as = textadept.adeptsense

-- [ctags.rust](https://github.com/mozilla/rust/blob/master/src/etc/ctags.rust)
-- NOTE: c is disabled in the tags builder. Will change this later on...
sense.ctags_kinds = {
  c = as.FIELD, d = as.CLASS, f = as.FUNCTION, g = as.FIELD, i = as.CLASS,
  m = as.CLASS, s = as.FIELD, t = as.CLASS, T = as.FIELD
}

sense:load_ctags(_USERHOME .. "/modules/rust/tags", true)

-- NOTE: api file still not produced. Need to make a script to do so.
--sense.api_files = {
--  _USERHOME .. '/modules/rust/api'
--}

sense.syntax.type_declarations = {
  -- missing explicit references and template! like `foo<T> : 'r bar`
  "([%w_%.]+): [%s*~@&]+%_[^%w_]", -- ONLY for normal declares.
}

-- add a trigger for auto sense
sense:add_trigger('.')
sense:add_trigger("::")




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
    fn    = "fn %1(name)(%2(param)) %3(-> %4(type) ){\n\t%0\n}",
    gfn   = "fn %1(name)<%2(T)>(%3(%4(param): &[T])) %5(-> %6(&[T])) {\n\t%0\n}",
    divfn = "fn %1(name)(%2(param)) ! {\n\t%0\n}",

    -- Items and Attributes
    extern  = "extern %1(\"ABI\") {\n\t%0\n}",
    struct  = "struct %1(name) {\n\t%0\n}",
    enum    = "enum %1(name) {\n\t%0\n}",
    mod     = "mod %1(name) {\n\t%0\n}",
    trait   = "trait %1(name) {\n\t%0\n}",
    impl    = "impl %1(name) %2(for %3(type)){\n\t%0\n}",

    -- Expressions
    v           = "[%1(start), %2(.. %3(range_end))]%0",
    l           = "|%1(param)| %0(expr)",
    ["while"]   = "while %1(expr) {\n\t%0\n}",
    loop        = "loop {\n\t%0\n}",
    ["do"]      = "do |%1(param)| {\n\t%0\n}",
    ["for"]     = "for %1(pattern) in %2(expr) {\n\t%0\n}",

    -- if
    ["if"]      = "if %1(expr) {\n\t%0\n}",
    ["ife"]     = "if %1(expr) {\n\t%2(block)\n} else %3(expr)",
    match       = "match %1(expr) {\n\t%2(pattern) => %3(expr)\n}",

    -- random
    ["#"]   = "#[%0(attribute)]",
    static  = "static %1(name): %2(type) = %0;",
    lmut    = "let mut %1(name): %2(type) = %0;",
    let     = "let %1(name): %2(type) = %0;",
    ["/*"]  = "/*\n\t%0\n*/"
  }
end


events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'rust' then return end

  buffer.tab_width = 4

end)

return {
  sense = sense
}
