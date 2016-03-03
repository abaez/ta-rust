# ta-rust
## A [Rust][4] module and lexer for [Textadept][5].

### DESCRIPTION
A module/lexer for Rust.

Currently, this module holds all keywords, types, and any other standard lexer
definition described by the [Rust reference][1]
manual. It also encompasses the vast list of snippets I use when coding,
ctags for semi auto-complete, api references, and lint support with
[rustfmt][2].

Now that Rust is finally stable, I'll be taking some time to put some real nice
autocomplete using [Racer][3] and any other
support later on.

#### Completed:
*   lexer: All keywords, types, library types, syntax extensions, strings, and
numbers lexer definitions.
*   module: *.rs, massive list of snippets, and API reference to all crates.
*   build: using cargo to make a build of a project.
*   lint: Basic lint support. (rustfmt ftw!)
*   autocomplete: An autocomplete working!

#### To Do:
*   autocomplete: level up the autocomplete to use [Racer][3].
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v1.7.0 (rev: [a5d1e7a][a5d1e7a])
*   Textadept >= v8.4
*   (optional) [textadept ctags][6]
*   (optional) [rustfmt][2]

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

If you have the [ctags][6] you will be also to
navigate directly to the source of the api reference.

The generated tag/api files are updated each time you run `cargo build`
from the `cB` command on textadept. This allows you to have one heck of an easy
way to deal with api lookups on a project directly from textadept!

If you have [rustfmt][2] installed or in your
path, then you can enable the init setting `_RUSTFMT` to true for your
`_USERHOME/init.lua`, to have autocorrect for formatting of your rust code:

```
-- init.lua
_RUSTFMT = true
```

If you want to edit snippets you can by pressing `cl+s` keys. `cl` first then
`s` key.

### KEYBINDINGS

    Keys        Action
    cB          cargo build and api/tags generation or update
    cl+s        quick edit for snippets
    s\n         adds `;` to the end of the current line and inserts newline
    a\n         appends `///` to the next line. (good for documentation)

[1]: http://doc.rust-lang.org/reference.html
[2]: https://github.com/nrc/rustfmt
[3]: https://github.com/phildawes/racer
[4]: http://www.rust-lang.org
[5]: http://foicica.com/textadept
[6]: http://foicica.com/hg/ctags/
[a5d1e7a]: https://github.com/rust-lang/rust/commit/a5d1e7a59a2a3413c377b003075349f854304b5e
