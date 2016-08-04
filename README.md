# ta-rust
## A [Rust][4] module and lexer for [Textadept][5].

### DESCRIPTION
A module/lexer for Rust.

Currently, this module holds all keywords, types, and any other standard lexer
definitions described by the [Rust reference][1]
manual. It also encompasses the vast list of snippets I use when coding,
ctags for semi auto-complete on user projects, api references with both self
engineered endeavor and [Racer][3] integration, and simple lint support with
[rustfmt][2].

#### Completed:
*   lexer: All keywords, primitive types, lifetime, library types, syntax
extensions, strings, and numbers lexer definitions.
*   module: *.rs, a humble list of snippets, and API reference to all **std** crates.
*   build: using cargo to make a build of a project.
*   lint: Basic lint support using [rustfmt][2] ftw!
*   autocomplete: A custom autocomplete AND [racer][3] support!


#### To Do:
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   user definitions: Get Racer to also do user definition reference lookup.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v1.10.0 (rev: [cfcb716c])
*   Textadept >= v8.4
*   (optional) [racer][3]
*   (optional) [textadept ctags][6]
*   (optional) [rustfmt][2]

### INSTALL
Clone the repository to your `~/.textadept/modules` directory:

```
cd ~/.textadept/modules
hg clone https://bitbucket.org/a_baez/ta-rust \
  rust
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
[`io.get_project_root()`][7]. A simple lexer refresh `f5` or `reset()` of
textadept will enable the api/tag references.

> **NOTE**: To use the `.tag_{project_name}` for auto referencing, you need to
have [ctags][6] module for [textadept][5]. You read more below under *ctags*.

These project generated api/tags will be read whenever you open a rust file in
a project containing the generated files. So if you press the keys for show
documentation `ch`, you'll get the prototypes and definition written for the
project. Better yet, you'll be able to use these values as autocomplete
throughout the project after the build. Hyper handy when you don't want to do
a quick lookup and instead just want to know what is the type structure. If you
do want the full lookup, that's also available

If you want to edit snippets, you can by pressing `cl+s` keys. `cl` first then
`s` key.

#### ctags
If you have the [ctags][6] you will also have the ability to
navigate directly to the source of the api reference.

The generated tag/api files are updated each time you run **cargo build**
from the `cB` or `cR` command on textadept. This allows you to have one heck of
an easy way to deal with api lookups on a project directly from textadept. As
discussed above, the `.tag_{project_name}` would appear in the root of your
project's directory. This allows you to navigate through the currently built
code by using the keys defined on [ctags][6] page of the module.

> **DISCLAIMER**: I have not used this ability in very long while and may end
up scratching it or building my own. There's also a great chance [ctags][6]
does not work anymore on textadept. :(

#### rustfmt
If you have [rustfmt][2] installed or in your
path, then you can enable the init setting **_RUSTFMT** to true for your
**_USERHOME/init.lua**, to have autocorrect for formatting of your rust code:

```
-- init.lua
_RUSTFMT = true
```

Now every time you save a file, you will have the lovable ability of
[rustfmt][2] autocorrecting your weird formatting. Yes I said it. Your
formatting is weird!

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
[cfcb716c]: https://github.com/rust-lang/rust/commit/cfcb716cf0961a7e3a4eceac828d94805cf8140b
