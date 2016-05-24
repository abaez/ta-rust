# ta-rust
## A [Rust][4] module and lexer for [Textadept][5].

### DESCRIPTION
A module/lexer for Rust.

Currently, this module holds all keywords, types, and any other standard lexer
definition described by the [Rust reference][1]
manual. It also encompasses the vast list of snippets I use when coding,
ctags for semi auto-complete on user projects, api references with both self
engineered endeavor and [Racer][3] integration, and lint support with
[rustfmt][2].

#### Completed:
*   lexer: All keywords, types, library types, syntax extensions, strings, and
numbers lexer definitions.
*   module: *.rs, massive list of snippets, and API reference to all crates.
*   build: using cargo to make a build of a project.
*   lint: Basic lint support. (rustfmt ftw!)
*   autocomplete: A custom autocomplete AND racer support!


#### To Do:
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   user definitions: Get Racer to also do user definition reference lookup.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v1.8.0 (rev: [db293940][db293940])
*   Textadept >= v8.4
*   (optional) [racer][3]
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

Any time you run **cargo build**, from the `cB` keys or the `cR` keys, you
will see `.tag_{project_name}` and `.api_{project_name}` files generated for
that specific project on the root directory of the project defined by
[`io.get_project_root()`][7].
A simple lexer refresh `f5` or `reset()` of textadept will enable the api/tag
references. These api/tags will also be read whenever you open a rust file in
a project containing the generated files. And as an added bonus, you can run the project without arguments as **cargo run** with `cr` keys.

If you want to edit snippets you can by pressing `cl+s` keys. `cl` first then
`s` key.

#### ctags
If you have the [ctags][6] you will be also to
navigate directly to the source of the api reference.

The generated tag/api files are updated each time you run **cargo build**
from the `cB` or `cR` command on textadept. This allows you to have one heck of an easy
way to deal with api lookups on a project directly from textadept!

#### rustfmt
If you have [rustfmt][2] installed or in your
path, then you can enable the init setting **_RUSTFMT** to true for your
**_USERHOME/init.lua**, to have autocorrect for formatting of your rust code:

```
-- init.lua
_RUSTFMT = true
```

#### racer
If you have [Racer][3] installed or in your path, then you can enable the init
setting **_RACER** to true from your **_USERHOME/init.lua**, to have autocorrect
for formatting of your rust code:

```
-- init.lua
_RACER = true
```

### KEYBINDINGS

    Keys        Action
    cB          cargo build and api/tags generation or update
    cR          same as `cB`
    cr          cargo run without arguments
    cl+s        quick edit for snippets
    s\n         adds `;` to the end of the current line and inserts newline
    a\n         appends `///` to the next line. (good for documentation)

[1]: http://doc.rust-lang.org/reference.html
[2]: https://github.com/rust-lang-nursery/rustfmt
[3]: https://github.com/phildawes/racer
[4]: http://www.rust-lang.org
[5]: http://foicica.com/textadept
[6]: http://foicica.com/hg/ctags/
[7]: http://foicica.com/textadept/api.html#io.get_project_root
[db293940]: https://github.com/rust-lang/rust/commit/db2939409db26ab4904372c82492cd3488e4c44e
