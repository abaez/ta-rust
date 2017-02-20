--- holds all snippets for rust.
-- @author [Alejandro Baez](https://keybase.io/baez)
-- @copyright 2014-2016
-- @license MIT (see LICENSE)
-- @module snippets

--- the list of all the snippets for rust.
-- @table snippets
return {

  -- functions
  fn    = "fn %1(name)(%2(&self)) %3(-> %4(type) ){%0}",
  gfn   = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5(type) ){%0}",
  divfn = "fn %1(name)(%2(param)) ! {%0}",

  -- closures
  [" |"]   = "|%1(|)",
  move    = "move |%1(:)| {%0})",
  -- :&
  fns     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: Fn(&%4) -> %5(Type) {%0}",
  -- :&mut
  fnm     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: FnMut(&%6) -> %7(Type) {%0}",
  -- :
  fno     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: FnOnce(%6) -> %7(Type) {%0}",

  -- Data Structures
  extern  = "extern %1(\"ABI\") {%0}",
  struct  = "struct %1(name) {%0}",
  enum    = "enum %1(name) {%0}",
  mod     = "mod %1(name) {%0}",
  trait   = "trait %1(name) {%0}",
  impl    = "impl %1(name) %2(for %3(type) ){%0}",

  -- Conditionals
  ["while"]   = "while %1(expr) {%0}",
  loop        = "loop {%0}",
  ["for"]     = "for %1(i) in %2(iterator) {%0}",
  ["forr"]    = "for %1(i) in range(%2(0), %3(10)) {%0}",
  ["whilel"]  = "while let %1(destructor) = %2(expr) {%0}",

  -- if
  ["if"]      = "if %1(expr) {%2(unimplemented!())} %0",
  ifl         = "if let %1(pattern) = %2(expr) {%3(unimplemented!())}",
  ["else"]    = 'else {%0}',
  match       = "match %1(expr) {%2(=>)}",

  -- let
  let     = "let %1(name)%2(: %3(type)) = %0;",
  lmut    = "let mut %1(name)%2(: %3(type)) = %0;",
  lvec    = "let %1(mut) %2(name): Vec<%3(T)> = Vec::new();",
  lbox    = "let %1(mut) %2(name): Box<%3(T)> = box %4(value);",

  -- comments
  ["/*"]    = "/*\n\t%0\n*/",
  ["/"]     = "//%1{/,!} ",

  -- tests
  modt      = "#[cfg(test)]\nmod tests {\n\tuse super::%1(*);\n\t%0\n};",
  test      = "#[test]",
  ["#t"]    = "#[test]\n%1(fn)",
  sp        = "#[should_panic]",
  ["a!"]    = "assert!(%1(boolean));",
  aq        = "assert_eq!(%1(result), %2(check));",
  panic     = "panic!(%1(error_message));",
  try       = "try!(%1(testing));",

  -- random
  ["#"]     = "#%1(!)[%2(attribute)]",
  crate     = "extern crate %1(name);",
  static    = "static %1(name): %2(type) = %0;",
  const     = "const %1(name): %2(type) = %0;",
  alias     = "type %1(alias) = %2(type);",
  ["print"] = 'println!("{%1}\\n", %2);',
  ["!!"]    = "%1(macro)!(%2(param))",
  ["{"]     = "{\n\t%0\n",
  ["{}"]    = "{\n\t%0\n}",
  ["=>"]    = "%1(pattern) => %2({})",

  -- tasks and communication
  ["spawn"]   = "spawn(move || {%0});",
  ["channel"] = "let (%1(tx, rx)): (Sender<%2(int)>, Receiver<%3(int)) = channel();",
}
