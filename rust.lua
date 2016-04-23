--- Rust LPeg lexer.
-- See @{README.md} for details on usage.
-- @author [Alejandro Baez](https://keybase.io/baez)
-- @copyright 2016
-- @license MIT (see LICENSE)
-- @module rust

local l = require("lexer")
local token, word_match = l.token, l.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'rust'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Comments.
local line_comment = '//' * l.nonnewline_esc^0
local block_comment = '/*' * (l.any - '*/')^0 * P('*/')^-1
local comment = token(l.COMMENT, line_comment + block_comment)

-- Strings.
local sq_str = P('L')^-1 * l.delimited_range("'")
local dq_str = P('L')^-1 * l.delimited_range('"')
local raw_str =  '#"' * (l.any - '#')^0 * P('#')^-1
local string = token(l.STRING, dq_str + raw_str)

-- Numbers.
local number = token(l.NUMBER, l.float + (l.dec_num + "_")^1 +
                     "0b" * (l.dec_num + "_")^1 + l.integer)

-- Keywords.
local keyword = token(l.KEYWORD, word_match{
  'abstract',   'alignof',    'as',       'become',   'box',
  'break',      'const',      'continue', 'crate',    'do',
  'else',       'enum',       'extern',   'false',    'final',
  'fn',         'for',        'if',       'impl',     'in',
  'let',        'loop',       'macro',    'match',    'mod',
  'move',       'mut',        "offsetof", 'override', 'priv',
  'proc',       'pub',        'pure',     'ref',      'return',
  'Self',       'self',       'sizeof',   'static',   'struct',
  'super',      'trait',      'true',     'type',     'typeof',
  'unsafe',     'unsized',    'use',      'virtual',  'where',
  'while',      'yield'
})

-- Library types
local library = token('library', l.upper * (l.lower + l.dec_num)^1)

-- syntax extensions
local extension = token('extension', l.word^1 * S("!"))

-- Types.
local type = token(l.TYPE, word_match{
  'bool', 'isize', 'usize', 'char', 'str',
  'u8', 'u16', 'u32', 'u64', 'i8', 'i16', 'i32', 'i64',
  'f32','f64',
})

-- Identifiers.
local identifier = token(l.IDENTIFIER, l.word)

-- Operators.
local operator = token(l.OPERATOR, S('+-/*%<>!=`^~@&|?#~:;,.()[]{}'))

-- Attributes.
local attribute = token('attribute', P('#![')^1 *
                        (l.nonnewline - ']')^0 * P("]")^-1)

M._rules = {
  {'whitespace', ws},
  {'keyword', keyword},
  {'extension', extension},
  {'library', library},
  {'type', type},
  {'string', string},
  {'comment', comment},
  {'number', number},
  {'attribute', attribute},
  {'operator', operator},
  {'identifier', identifier},
}

M._tokenstyles = {
  attribute = l.STYLE_PREPROCESSOR,
  library = l.STYLE_CLASS,
  extension = l.STYLE_FUNCTION
}

M._foldsymbols = {
  _patterns = {'%l+', '[{}]', '/%*', '%*/', '//'},
  [l.COMMENT] = {['/*'] = 1, ['*/'] = -1, ['//'] = l.fold_line_comments('//')},
  [l.OPERATOR] = {['('] = 1, ['{'] = 1, [')'] = -1, ['}'] = -1}
}

return M
