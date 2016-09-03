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

### [USERGUIDE]

Check the [USERGUIDE] for more information on how to use.

[USERGUIDE]: ./USERGUIDE.md

[1]: http://doc.rust-lang.org/reference.html
[2]: https://github.com/rust-lang-nursery/rustfmt
[3]: https://github.com/phildawes/racer
[4]: http://www.rust-lang.org
[5]: http://foicica.com/textadept
[6]: http://foicica.com/hg/ctags/
[7]: http://foicica.com/textadept/api.html#io.get_project_root
[cfcb716c]: https://github.com/rust-lang/rust/commit/cfcb716cf0961a7e3a4eceac828d94805cf8140b
