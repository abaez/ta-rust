# ta-rust
[![license][8i]][8p]
[![twitter][9i]][9p]

A [Rust][4] module and lexer for [Textadept][5].

### DESCRIPTION
A module/lexer for Rust.

Currently, this module holds all keywords, types, and any other standard lexer
definitions described by the [Rust reference][1]
manual. It also encompasses the vast list of snippets I use when coding,
ctags for semi auto-complete on user projects, api references with both self
engineered endeavor and [racer] integration, and simple lint support with
[rustfmt].

#### Completed:
*   lexer: All keywords, primitive types, lifetime, library types, syntax
extensions, strings, and numbers lexer definitions.
*   module: *.rs, a humble list of snippets, and API reference to all **std** crates.
*   build: using cargo to make a build of a project.
*   lint: Basic lint support using [rustfmt] ftw!
*   autocomplete: A custom autocomplete AND [racer] support!


#### To Do:
*   unit test: somehow get unit test integrated better.
*   rustdoc: Make some rustdoc integration as well, while we at it.
*   user definitions: Get Racer to also do user definition reference lookup.
*   Make this module the damn bloody best way to code in Rust.

### REQUIREMENT
*   Rust >= v1.15.0 (rev: [10893a9a])
*   Textadept >= v9.0
*   (optional) [racer]
*   (optional) [textadept ctags][6]
*   (optional) [rustfmt]

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

Check the [USERGUIDE] for more information on how to use this wonderful module.

[USERGUIDE]: ./USERGUIDE.md

[1]: http://doc.rust-lang.org/reference.html
[rustfmt]: https://github.com/rust-lang-nursery/rustfmt
[racer]: https://github.com/phildawes/racer
[4]: http://www.rust-lang.org
[5]: http://foicica.com/textadept
[6]: http://foicica.com/hg/ctags/
[7]: http://foicica.com/textadept/api.html#io.get_project_root
[10893a9a]: https://github.com/rust-lang/rust/commit/10893a9a349cdd423f2490a6984acb5b3b7c8046
[8i]: https://img.shields.io/badge/license-MIT-green.svg
[8p]: ./LICENSE
[9i]: https://img.shields.io/badge/twitter-a_baez-blue.svg
[9p]: https://twitter.com/a_baez
