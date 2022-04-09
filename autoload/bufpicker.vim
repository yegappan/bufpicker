" File: bufpicker.vim
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Last Modified: March 9, 2022
"
" Plugin to display the list of buffers in the quickfix list.
" =======================================================================

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

let s:qfID = 0
let s:buflistNeedUpdate = v:false

func bufpicker#bufenter()
  let s:buflistNeedUpdate = v:true
endfunc

func bufpicker#safestate()
  if s:buflistNeedUpdate
    call bufpicker#update(v:false)
  endif
endfunc

func s:QfBufferName(info)
  let items = getqflist(#{id: a:info.id, items: v:true}).items
  return items->map('bufname(v:val.bufnr)')
endfunc

func bufpicker#update(qfopen) abort
  let s:buflistNeedUpdate = v:false
  let bufs = getbufinfo(#{buflisted: v:true})
  let bufs = bufs->sort({a, b -> a.lastused < b.lastused})
  let bufs = bufs->filter('v:val.name != ""')
  let items = map(bufs, '{"bufnr": v:val.bufnr}')

  let s:qfID = getqflist(#{id: s:qfID}).id
  let d = #{items: items, quickfixtextfunc: 's:QfBufferName'}
  if s:qfID != 0
    let d['id'] = s:qfID
    let d['title'] = 'Buffer Picker'
  endif
  call setqflist([], 'r', d)
  if a:qfopen
    copen
  endif
endfunc

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:
