" File: bufpicker.vim
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Last Modified: March 9, 2022
"
" Plugin to display the list of buffers in the quickfix list.
" =======================================================================

if exists('loaded_bufpicker')
  finish
endif
let loaded_bufpicker=1

command! BufPicker call bufpicker#update(v:true)
augroup BufPicker
  au!
  au BufEnter * call bufpicker#bufenter()
  au SafeState * call bufpicker#safestate()
augroup END

" vim:set sw=2 sts=2:
