-- Copyright 2014 Alejandro Baez <Alejan.Baez@gmail.com> See LICENSE.
-- Rust LPeg lexer.

local l, token, word_match = lexer, lexer.token, lexer.word_match
local P, R, S = lpeg.P, lpeg.R, lpeg.S

local M = {_NAME = 'rust'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Comments.
local line_comment = '//' * l.nonnewline_esc^0
local block_comment = '/*' * (l.any - '*/')^0 * P('*/')^-1
local comment = token(l.COMMENT, line_comment + block_comment)

-- Strings.
--local sq_str = P('L')^-1 * l.delimited_range("'", true)
local dq_str = P('L')^-1 * l.delimited_range('"', true)
--local string = token(l.STRING, sq_str + dq_str)
local string = token(l.STRING, dq_str)

-- Numbers.
local number = token(l.NUMBER, l.float + "0b" * l.integer + "0o" * l.integer +
  l.integer)

-- Keywords.
local keyword = token(l.KEYWORD, word_match{
  'as', 'box', 'break',
  'continue', 'crate',
  'else', 'enum', 'extern',
  'false', 'fn', 'for',
  'if', 'impl', 'in',
  'let', 'loop',
  'match', 'mod', 'mut',
  'priv', 'proc', 'pub',
  'ref', 'return',
  'self', 'static', 'struct', 'super',
  'true', 'trait', 'type',
  'unsafe', 'use',
  'while'
})

-- Types.
local type = token(l.TYPE, word_match{
  '()', 'bool', 'int', 'uint', 'char', 'str',
  'u8', 'u16', 'u32', 'u64', 'i8', 'i16', 'i32', 'i64',
  'f32','f64',
})

-- Identifiers.
local identifier = token(l.IDENTIFIER, l.word)

-- Operators.
local operator = token(l.OPERATOR, S('+-/*%<>!=`^~@&|?#~:;,.()[]{}'))

-- Attributes.
local attribute = token(l.PREPROCESSOR, "#[" * l.nonnewline^0 * "]")

M._rules = {
  {'whitespace', ws},
  {'keyword', keyword},
  {'type', type},
  {'identifier', identifier},
  {'string', string},
  {'comment', comment},
  {'number', number},
  {'operator', operator},
  {'preprocessor', attribute},
}

M._foldsymbols = {
  _patterns = {'%l+', '[{}]', '/%*', '%*/', '//'},
  [l.COMMENT] = {['/*'] = 1, ['*/'] = -1, ['//'] = l.fold_line_comments('//')},
  [l.OPERATOR] = {['('] = 1, ['{'] = 1, [')'] = -1, ['}'] = -1}
}

return M
