" Location:     plugin/shifty.vim
" Author:       thomasjlsn (https://github.com/thomasjlsn)
" Version:      0.1
" License:      Same as Vim itself.  See :help license

" Functions shamelessly stolen from https://www.youtube.com/watch?v=X5IAdaN6IwM (Vim screencast #65: Moving lines vertically)
"   Credit: Greg Hurrell (https://github.com/wincent)
function! s:Visual()
  return visualmode() == 'V'
endfunction

set lazyredraw

function! Shift_up() abort range
  let l:at_top=a:firstline == 1
  if s:Visual() && !l:at_top
    '<,'>move '<-2
    call feedkeys('gv=', 'n' )
  endif
  call feedkeys('gv', 'n' )
endfunction

function! Shift_down() abort range
  let l:at_bottom=a:lastline == line('$')
  if s:Visual() && !l:at_bottom
    '<,'>move '>+1
    call feedkeys('gv=', 'n' )
  endif
  call feedkeys('gv', 'n' )
endfunction

" Improve default shifting mappings
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" Shifting lines
nnoremap <C-h> <<
nnoremap <C-j> V:move '>+1<CR>gv=gv<ESC>:echo "1 line shifted down"<CR>
nnoremap <C-k> V:move '<-2<CR>gv=gv<ESC>:echo "1 line shifted up"<CR>
nnoremap <C-l> >>

" Shifting blocks
vnoremap <C-h> <gv
vnoremap <C-j> :call Shift_down()<CR>
vnoremap <C-k> :call Shift_up()<CR>
vnoremap <C-l> >gv
