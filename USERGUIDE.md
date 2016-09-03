# User Guide
A hopefule guide on how to use [ta-rust].


## Keys shorthand
The keys used here follow the formatting [Textadept's key binding][2]

> **DISCLAIMER**: The keys described on this guide, all use formatting
associated to linux for the key shortcuts. As such, if you see commands written
in a way which aren't for your os of choice (ie: macos), then simply change
the key bindings to conform to your os of choice.


### A project's auto-complete
The module currently allows you to have cargo project built api and tags.
This means that with each build run of a
library or project, in Textadept, you would be able to get both prototype
references to an api ([Textadept's built referencing tool][1]) and direct
*goto source* of the reference (Textadept's [ctags] module).


#### Api reference of project
You have access to api references from any cargo built library/program you
compile through textadept.

Any time you run **cargo build**, from the `cB` keys or the `cR` keys, you
will see `.tag_{project_name}` and `.api_{project_name}` files generated for
that specific project on the root directory of the project defined by
[`io.get_project_root()`][7]. A simple lexer refresh `f5` or `reset()` of
textadept will enable the api/tag references.

> **NOTE**: To use the `.tag_{project_name}` for auto goto referencing, you
need to have [ctags] module for [textadept]. You can read more below
under *ctags* for usage.

These projects generated api/tags will be parsed whenever you open a rust file
in a project containing the generated files.

**Example**: if you press the keys for
showing documentation `ch`, you'll get the prototypes or definition written
for the project type you are looking up. Better yet, you'll be able to use
these values as autocomplete throughout the project after the build by the
default `c\s` keys. Hyper handy when you don't want to do
a quick lookup and instead just want to know what is the type structure. If you
do want the full goto lookup, that's also available through the [**ctags**]
module.

#### [ctags] reference of project
If you have the [ctags] you will also have the ability to
navigate directly to the source of the api reference.

The generated tag/api files are updated each time you run **cargo build**
from the `cB` or `cR` command on textadept as discussed above.
This allows you to have one heck of an easy way to deal with api lookups on a
project directly from textadept. As discussed above, the `.tag_{project_name}`
would appear in the root of your project's directory.

Going with the default configuration for [ctags] module, you would first
have the following keys mapped on your `_USERHOME/init.lua` file:

``` lua
-- init.lua
local ctags = require "ctags"

keys['a&'] = ctags.goto_tag
keys['a,'] = {ctags.goto_tag, nil, true} -- back
keys['a.'] = {ctags.goto_tag, nil, false} -- forward
keys['ac'] = {textadept.editing.autocomplete, 'ctag'}
```

Then, once you have run the `cB` or `cR` keys, you would be able to navigate
to the goto reference of the Rust project by the keys defined above.

### Editing snippets
If you want to edit snippets, you can by pressing `cl+s` keys. `cl` first then
`s` key. After wards, you

### Using rustfmt
If you have [rustfmt] installed or in your path, then you can enable the init
setting **_RUSTFMT** to true for your **_USERHOME/init.lua**, to have
autocorrect for formatting of your rust code:

```
-- init.lua
_RUSTFMT = true
```

Now every time you save a file, you will have the lovable ability of
[rustfmt] autocorrecting your weird formatting. Yes I said it. Your
formatting is weird!

### Using [racer]
If you have [racer] installed or in your path, then you can enable the init
setting **_RACER** to true from your **_USERHOME/init.lua**, to have autocorrect
for formatting of your rust code:

```
-- init.lua
_RACER = true
```

> **NOTE**: It's not required to use [racer] to get autocomplete. Due to the
age of this module for Rust, I wrote an autocomplete which predates [racer] and
works pretty well for Textadept already. Meaning, you only need [racer] enabled
if you want to use [racer] instead of the in-built autocompleter.

### All Key binding

  Keys        Action
  cB          cargo build and api/tags generation or update
  cr          cargo run without arguments
  cl+s        quick edit for snippets
  s\n         adds `;` to the end of the current line and inserts newline
  a\n         appends `///` to the next line. (good for documentation)


[ta-rust]: ./README.md
[ctags]: http://foicica.com/hg/ctags/
[textadept]: http://foicica.com/textadept/
[rustfmt]:  https://github.com/rust-lang-nursery/rustfmt
[racer]: https://github.com/phildawes/racer

[1]: http://foicica.com/textadept/api.html#_M.Autocompletion.and.Documentation
[2]: http://foicica.com/textadept/manual.html#Preferences
[7]: http://foicica.com/textadept/api.html#io.get_project_root
