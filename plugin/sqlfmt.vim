if !exists('g:sqlfmt_command')
  let g:sqlfmt_command = 'snowflakefmt'
endif

if !executable(g:sqlfmt_command) || !get(g:, 'sqlfmt_auto', 1)
  finish
endif

augroup SQLFmt
  au!
  autocmd BufWritePre *.sql call sqlfmt#run()
augroup END
