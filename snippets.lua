--- holds all snippets for rust.
-- @author [Alejandro Baez](https://keybase.io/baez)
-- @copyright 2014-2016
-- @license MIT (see LICENSE)
-- @module snippets

--- the list of all the snippets for rust.
-- @table snippets
return {

  -- functions
  fn    = "fn %1(name)(%2(&self)) %3(-> %4(type) ){\n\t%0\n}",
  gfn   = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5(type) ){\n\t%0\n}",
  divfn = "fn %1(name)(%2(param)) ! {\n\t%0\n}",

  -- closures
  ["|"]   = "|%1(|)",
  move    = "move |%1(:)| {\n\t%0\n})",
  -- :&
  fns     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: Fn(&%4) -> %5\n{\n\t%0\n}",
  -- :&mut
  fnm     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: FnMut(&%6) -> %7\n{\n\t%0\n}",
  -- :
  fno     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: FnOnce(%6) -> %7\n{\n\t%0\n}",

  -- Data Structures
  extern  = "extern %1(\"ABI\") {\n\t%0\n}",
  struct  = "struct %1(name) {\n\t%0\n}",
  enum    = "enum %1(name) {\n\t%0\n}",
  mod     = "mod %1(name) {\n\t%0\n}",
  trait   = "trait %1(name) {\n\t%0\n}",
  impl    = "impl %1(name) %2(for %3(type) ){\n\t%0\n}",

  -- Conditionals
  ["while"]   = "while %1(expr) {\n\t%0\n}",
  loop        = "loop {\n\t%0\n}",
  ["for"]     = "for %1(i) in %2(iterator) {\n\t%0\n}",
  ["forr"]    = "for %1(i) in range(%2(0), %3(10)) {\n\t%0\n}",
  ["whilel"]  = "while let %1(destructor) = %2(expr) {\n\t%0\n}",

  -- if
  ["if"]      = "if %1(expr) {\n\t%2\n} %0",
  ifl         = "if let %1(pattern) = %2(expr) {\n\t%3\n} %0",
  ["else"]    = 'else {\n\t%0\n}',
  match       = "match %1(expr) {\n\t%2(pattern) => %3(expr)\n}",

  -- let
  let     = "let %1(name)%2(: %3(type)) = %0;",
  lmut    = "let mut %1(name)%2(: %3(type)) = %0;",
  lvec    = "let %1(mut) %2(name): Vec<%3(T)> = Vec::new();%0",
  lbox    = "let %1(mut) %2(name): Box<%3(T)> = box %4(value);%0",

  -- comments
  ["/*"]    = "/*\n\t%0\n*/",
  ["/"]     = "//%1(/)",

  -- tests
  modt      = "#[cfg(test)]\nmod tests {\n\tuse super::%1(*);\n\t%0\n};",
  test      = "#[test]%0",
  ["#t"]    = "#[test]\n%1(fn)",
  sp        = "#[should_panic]%0",
  ["a!"]    = "assert!(%1(boolean));%0",
  aq        = "assert_eq!(%1(result), %2(check));%0",
  panic     = "panic!(%1(error_message));%0",
  try       = "try!(%1(testing));%0",

  -- random
  ["#"]     = "#%1(!)[%2(attribute)]%0",
  crate     = "extern crate %1(name);%0",
  static    = "static %1(name): %2(type) = %0;",
  const     = "const %1(name): %2(type) = %0;",
  alias     = "type %1(alias) = %2(type);%0",
  ["print"] = 'println!("{%1}\\n", %2);%0',
  ["!!"]    = "%1(macro)!(%2(param))%0",
  ["{"]     = "{\n\t%0\n",

  -- tasks and communication
  ["spawn"]   = "spawn(move || {\n\t%0\n});",
  ["channel"] = "let (%1(tx, rx)): (Sender<%2(int)>, Receiver<%3(int)) = channel();%0",
}
