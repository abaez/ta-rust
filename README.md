# ta-rust
## A [Rust](http://www.rust-lang.org) module and lexer for [Textadept](http://foicica.com/textadept/).

### DESCRIPTION
A module/lexer for Rust. I recently decided to take a month and learn
Textadept. Turns out the little gem of a texteditor is much more
powerful that I thought it would be and I decided to keep using it. However,
it's missing a couple of features and languages that I like using. Rust is one
of those languages.

Currently, this module holds all keywords, types, and any other standard lexer
definition described by the [Rust reference](http://doc.rust-lang.org/0.11.0/rust.html)
manual. It also encompasses the a vast list of snippets I use when coding,
ctags for semi auto-complete, and api references.

Note: The API references are currently just the presentation of the prototypes
for an API call. I believe with how Rust work, these prototypes are good enough for each reference call.

#### Completed:
*   lexer: All keywords, types, library types, syntax extensions, strings, and
numbers lexer definitions.
*   module: *.rs, massive list of snippets, and API reference to all crates as of v0.11.

#### To Do:
*   autocomplete: An actual autocomplete working...(finally)
*   lint: Basic lint from post compile. (better than what is implemented now)
*   build: using cargo to make a build of a project. (should be fun to do...)
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v0.13
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
