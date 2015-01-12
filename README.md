# ta-rust
## A [Rust](http://www.rust-lang.org) module and lexer for [Textadept](http://foicica.com/textadept/).

### DESCRIPTION
A module/lexer for Rust.

Currently, this module holds all keywords, types, and any other standard lexer
definition described by the [Rust reference](http://doc.rust-lang.org/reference.html)
manual. It also encompasses the a vast list of snippets I use when coding,
ctags for semi auto-complete, and api references.

Note: The API references are currently just the presentation of the prototypes
for an API call. I believe with how Rust work, these prototypes are good enough
for each reference call.

#### Completed:
*   lexer: All keywords, types, library types, syntax extensions, strings, and
numbers lexer definitions.
*   module: *.rs, massive list of snippets, and API reference to all crates.
*   build: using cargo to make a build of a project.

#### To Do:
*   autocomplete: An actual autocomplete working...(finally)
*   lint: Basic lint from post compile. (better than what is implemented now)
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v1.0.0 (rev: [e7b397b02e](https://github.com/rust-lang/rust/commit/e7b397b02e49ab6af5bc2a30dd04c19c38e0e266))
*   Textadept >= v7.3

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
