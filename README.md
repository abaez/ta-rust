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

### INSTALL
Clone the repository to your `~/.textadept/modules` directory:

```
cd ~/.textadept/modules
hg clone https://bitbucket.org/a_baez/ta-rust rust
```

Then copy the `rust.lua` lexer file into your `~/.textadept/lexers` directory:

```
cp ~/.textadept/modules/rust/rust.lua ~/.textadept/lexers/rust.lua
```

Finally, append to your `~/.textadept/init.lua` file the module through the
file extension. Need to do this, since the file type extension declares the
lexer:

```
textadept.file_types.extensions.rs = 'rust'
```
