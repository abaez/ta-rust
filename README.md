# ta-rust
## A [Rust](http://www.rust-lang.org) module and lexer for [Textadept](http://foicica.com/textadept/).

### DESCRIPTION
A work in progress module/lexer for Rust. I recently decided to take a month
and learn Textadept. Turns out the little gem of a texteditor is much more
powerful that I thought it would be and I decided to keep using it. However,
it's missing a couple of features and languages that I like using. Rust is one
of those languages.

This project is to make a full lexer and full module for Rust. The final goal
is to have complete API documentation using Adeptsense.

#### Completed:
*   lexer: All keywords, types, and numbers lexer definitions.
*   module: *.rs and massive list of snippets.

#### Currently Planned:
*   lexer: std library, expressions, and special definition for strings and
explicit lifetime references.
*   module: API reference to all keywords, types, strings, pointers,

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
