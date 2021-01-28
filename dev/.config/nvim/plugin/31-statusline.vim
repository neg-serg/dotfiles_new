scriptencoding=utf-8
let g:currentmode={
      \ 'n'  : 'N',
      \ 'no' : 'Normal·Operator Pending',
      \ 'v'  : 'V',
      \ 'V'  : 'V·Line',
      \ '^V' : 'V·Block',
      \ 's'  : 'S',
      \ 'S'  : 'S·Line',
      \ '^S' : 'S·Block',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'Rv' : 'V·Replace',
      \ 'c'  : 'C',
      \ 'cv' : 'Vim Ex',
      \ 'ce' : 'Ex',
      \ 'r'  : 'Prompt',
      \ 'rm' : 'More',
      \ 'r?' : 'Confirm',
      \ '!'  : '!',
      \ 't'  : 'T'
      \}

function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! ModeCurrent() abort
    let l:modecurrent = mode()
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! GitBranch(git)
    if a:git ==# ''
        return ''
    else
        return ' ' . a:git . ' '
    endif
endfunction

function! CheckFT(filetype)
    if a:filetype ==# ''
        return ''
    else
        return tolower(a:filetype)
    endif
endfunction

function! VisualSelectionSize()
    if mode() == "v"
        " Exit and re-enter visual mode, because the marks
        " ('< and '>) have not been updated yet.
        exe "normal \<ESC>gv"
        if line("'<") != line("'>")
            return (line("'>") - line("'<") + 1) . ' lines'
        else
            return (col("'>") - col("'<") + 1) . ' chars'
        endif
    elseif mode() == "V"
        exe "normal \<ESC>gv"
        return (line("'>") - line("'<") + 1) . ' lines'
    elseif mode() == "\<C-V>"
        exe "normal \<ESC>gv"
        return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block'
    else
        return ''
    endif
endfunction

function! CheckMod(modi)
    if a:modi == 1
        hi Modi guifg=#8fa7c7 guibg=NONE
        hi Filename guifg=#8fa7c7 guibg=NONE
        return expand('%:t').' 􏅋 '
    else
        hi Modi guifg=#6587b3 guibg=NONE
        hi Filename guifg=#8fa7c7 guibg=NONE
        return expand('%:t')
    endif
endfunction

function! ActiveLine()
    let statusline = ''
    let statusline .= '%#Base#'
    let statusline .= '%#Mode# %{ModeCurrent()}'
    let statusline .= ' %{VisualSelectionSize()}'
    let statusline .= '%#StatusLeftDelimiter1# ❯>'
    let statusline .= '%#Modi# %{CheckMod(&modified)}'
    let statusline .= "%#Git# %{get(g:,'coc_git_status','')}"
    let statusline .= '%#Decoration# '
    let statusline .= '%3* '
    let statusline .= '%= '
    let statusline .= '%#Decoration# '
    let statusline .= '%#Filetype#%{CheckFT(&filetype)} '
    " thx to github.com/VaughnValle/elektropunk
    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    if exists("*coc#status")
        let statusline .= '%{coc#status()}' . "%{get(b:,'coc_current_function','')}"
    endif
    let statusline .= '%3*'
    let statusline .= '%#StatusRightDelimiter1#❮'
    let statusline .= '%1*'
    let statusline .= '%#StatusRight# %02l%#StatusRightDelimiter1#/%#StatusRight#%02v'
    let statusline .= '%#StatusRightDelimiter1# ❮ '
    let statusline .= '%#StatusRight#%2p%% '
    return statusline
endfunction

function! InactiveLine()
    let statusline = '%#Base# %#Filename# %.20%F '
    return statusline
endfunction

augroup Statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
augroup END
