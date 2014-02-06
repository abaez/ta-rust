textadept.file_types.extensions.rs = 'rust'


-- Table of Rust-specific key bindings.
-- @class table
-- @name _G.keys.ansi_c
keys.rust = {
  [keys.LANGUAGE_MODULE_PREFIX] = {
    m = {io.open_file, _HOME..'/modules/rust/init.lua'},
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
    impl    = "impl %1(name) %2(for %3(type)) {\n\t%0\n}",

    -- Expressions
    v           = "[%1(start), ..%2(range_end)] %0",
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

return {}
