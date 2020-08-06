function! sqlfmt#run(...) abort
  if g:sqlfmt_command ==# ''
    let g:sqlfmt_command = 'snowflakefmt'
  endif
  if !executable(g:sqlfmt_command)
    redraw
    echohl ErrorMsg | echomsg printf('%s: command not found', g:sqlfmt_command) | echohl None
    return
  endif

  let files = len(a:000) > 0 ? a:000 : [expand('%')]
  let files = map(files, 'shellescape(expand(v:val))')
  let err_file = tempname()
  let lines = systemlist(printf(
              \ '%s %s %s 2> %s',
              \ g:sqlfmt_command, g:sqlfmt_options, join(files, ' '), err_file
              \ ))

  " clear quickfix before we get started
  cexpr []

  if v:shell_error == 0
    let pos = getcurpos()
    silent! %d _
    call setline(1, lines)
    call setpos('.', pos)
  endif

  let err_lines = systemlist(printf(
                  \ 'cat %s',
                  \ err_file
                  \ ))

  " No matter the exit code, stderr should be quickfixed
  " (either error or warnings)
  " Use our error format and reset it after
  let s:prev_error_format = &errorformat
  set errorformat=%f:%l:%c:%tarning:%m,%f:%l:%c:%trror:%m,%f:%l:%c:%m,%f:%l:%c:%m,
  cexp err_lines
  let &errorformat=s:prev_error_format

  if len(getqflist()) > 0
    copen | cc
  else
    cclose
  endif

endfunction
