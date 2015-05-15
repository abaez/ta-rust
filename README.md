# ta-rust
## A [Rust](http://www.rust-lang.org) module and lexer for [Textadept](http://foicica.com/textadept/).

### DESCRIPTION
A module/lexer for Rust.

Currently, this module holds all keywords, types, and any other standard lexer
definition described by the [Rust reference](http://doc.rust-lang.org/reference.html)
manual. It also encompasses the vast list of snippets I use when coding,
ctags for semi auto-complete, and api references.

Now that Rust is finally stable, I'll be taking some time to put some real nice
autocomplete using [Racer](https://github.com/phildawes/racer) and post lint
support with [rustfmt](https://github.com/nrc/rustfmt) later on.

#### Completed:
*   lexer: All keywords, types, library types, syntax extensions, strings, and
numbers lexer definitions.
*   module: *.rs, massive list of snippets, and API reference to all crates.
*   build: using cargo to make a build of a project.

#### To Do:
*   autocomplete: An actual autocomplete working...(anyone say racer?)
*   lint: Basic lint from post compile. (rustfmt ftw!)
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v1.0.0 (rev: [4db0b324](https://github.com/rust-lang/rust/commit/4db0b32467535d718d6474de7ae8d1007d900818))
*   Textadept >= v7.9
*   (optional) [textadept ctags](http://foicica.com/hg/ctags/)

### INSTALL
Clone the repository to your `~/.textadept/modules` directory:

```
cd ~/.textadept/modules
hg clone https://bitbucket.org/a_baez/ta-rust rust
```

You are done! If you want to use the latest in development version of the lexer
(follows the rust nightlies), then continue along.

#### rust nightlies lexer
Copy the `rust.lua` lexer file into your `~/.textadept/lexers` directory:

```
cp ~/.textadept/modules/rust/rust.lua ~/.textadept/lexers/rust.lua
```

### USAGE
A couple of things to know. The module currently allows you to have
cargo project built api and tags. In other words, you have access to api
references from any cargo built library/program you build through textadept.

Any time you run `cargo build`, from the `cB` keys, you will see
`.tag_{project_name}` and `.api_{project_name}` files generated for that
specific project on the root directory of the project.
A simple lexer refresh `f5` or `reset()` of textadept will enable the api/tag
references. These api/tags will also be read whenever you open a rust file in
a project containing the generated files.

If you have the [ctags](http://foicica.com/hg/ctags/) you will be also to
navigate directly to the source of the api reference.

The generated tag/api files are updated each time you run `cargo build`
from the `cB` command on textadept. This allows you to have one heck of an easy
way to deal with api lookups on a project directly from textadept!

If you want to edit snippets you can by pressing `cl+s` keys. `cl` first then
`s` key.

### KEYBINDINGS

    Keys        Action
    cB          cargo build && api/tags generation or update
    cl+i        quick edit for snippets
    s\n         adds `;` to the end of the current line and inserts newline
    a\n         appends `///` to the next line. (good for documentation)



