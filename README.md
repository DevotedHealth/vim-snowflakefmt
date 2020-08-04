# vim-snowflakefmt

Run `snowflakefmt` on sql code.

`snowflakefmt` is an internal binary so unfortunately, this won't work outside of Devoted Health at the moment. You can set the command with `let g:sqlfmt_command = 'sqlfmt'` or something else, but should considering using https://github.com/b4b4r07/vim-sqlfmt, which this project is just a light modification around. 

## Installation

```vim
Plugin 'DevotedHealth/vim-snowflakefmt'
```

## Usage

Run `:w` to format automatically after save. If you set `g:sqlfmt_auto` to 0, this behavior will be disabled.

It can also be executed directly as follows:

```vim
:SQLFmt [files...]
```

