--- holds all snippets for rust.
-- @author Alejandro Baez <alejan.baez@gmail.com>
-- @copyright 2014
-- @license MIT (see LICENSE)
-- @module snippets

--- the list of all the snippets for rust.
-- @table snippets
return {

  -- functions
  fn    = "fn %1(name)(%2(&self)) %3(-> %4(type) ){\n\t%0\n}",
  gfn   = "fn %1(name)<%2(T)>(%3(%4(param): %2)) %5(-> %6(%2)) {\n\t%0\n}",
  divfn = "fn %1(name)(%2(param)) ! {\n\t%0\n}",

  -- closures
  -- :&
  fns     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: Fn(&%4) -> %5\n{\n\t%0\n}",
  -- :&mut
  fnm     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: FnMut(&%6) -> %7\n{\n\t%0\n}",
  -- :
  fno     = "fn %1(name)<%2(T)>(%3(param): %2) %4(-> %5 )\n\t" ..
            "where %2: FnOnce(%6) -> %7\n{\n\t%0\n}",
  ["|"]   = "|%1(:)| %0",
  move    = "move |%1(:)| {\n\t%0\n})",

  -- Data Structures
  extern  = "extern %1(\"ABI\") {\n\t%0\n}",
  struct  = "struct %1(name) {\n\t%0\n}",
  enum    = "enum %1(name) {\n\t%0\n}",
  mod     = "mod %1(name) {\n\t%0\n}",
  trait   = "trait %1(name) {\n\t%0\n}",
  impl    = "impl %1(name) %2(for %3(type) ){\n\t%0\n}",

  -- Expressions
  v           = "[%1(start), %2(.. %3(range_end))]%0",
  ["while"]   = "while %1(expr) {\n\t%0\n}",
  loop        = "loop {\n\t%0\n}",
  ["for"]     = "for %1(i) in %2(iterator) {\n\t%0\n}",
  ["forr"]    = "for %1(i) in range(%2(0), %3(10)) {\n\t%0\n}",

  -- if
  ["if"]      = "if %1(expr) {\n\t%2\n} %0",
  ifl         = "if let %1(pattern) = %2(expr) {\n\t%3\n} %0",
  ["else"]    = 'else {\n\t%0\n}',
  match       = "match %1(expr) {\n\t%2(pattern) => %3(expr)\n}",

  -- let
  let     = "let %1(name): %2(type) = %0;",
  lmut    = "let mut %1(name): %2(type) = %0;",
  lvec    = "let %1(mut) %2(name): Vec<%3(T)> = Vec::new();%0",
  lbox    = "let %1(mut) %2(name): Box<%3(T)> = box %4(value);%0",

  -- random
  ["#"]     = "#%1(!)[%2(attribute)]%0",
  crate     = "extern crate %1(name);%0",
  static    = "static %1(name): %2(type) = %0;",
  ["/*"]    = "/*\n\t%0\n*/",
  ["print"] = 'println!("{%1(name)}\\n", %1);%0',

  -- tasks and communication
  ["spawn"]   = "spawn(move || {\n\t%0\n});",
  ["channel"] = "let (%1(tx, rx)): (Sender<%2(int)>, Receiver<%3(int)) = channel();%0",
}
