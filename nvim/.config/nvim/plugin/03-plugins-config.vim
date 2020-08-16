" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - neoclide/coc.nvim                                                        │
" │ https://github.com/neoclide/coc.nvim                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_status_warning_sign = ""
let g:coc_status_error_sign = ""

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [Qleader]c <Plug>(coc-diagnostic-next)
nmap <silent> [Qleader]C <Plug>(coc-diagnostic-prev)
nmap <silent> <M-CR> <Plug>(coc-fix-current)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Show all diagnostics
nnoremap <silent> qa  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> qE  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> qC  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> qo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> qs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> qj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> qk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> qp  :<C-u>CocListResume<CR>
" Try autofix current
nmap <leader>qf  <Plug>(coc-fix-current)
" Reformat command
command! -nargs=0 Format :call CocAction('format')
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - xolox/vim-session                                                        │
" │ https://github.com/xolox/vim-session                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:session_lock_enabled = 0
let g:session_verbose_messages = 0
let g:session_autosave_silent = 1
let g:session_default_to_last = 1
let g:session_autosave_to = 'default'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_directory = $XDG_CONFIG_HOME.'/nvim/sessions'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - w0rp/ale                                                                 │
" │ https://github.com/w0rp/ale                                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_highlight_linenrs = 1
let g:ale_linters = {'python': ['flake8', 'pylint'], 'rust': ['rls']}
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_fixers = {'javascript': ['eslint'], 'json': ['jq'], 'html': ['prettier'], 'scss': ['stylelint'], 'less': ['stylelint'], 'css': ['stylelint'], 'python': ['black', 'yapf'], 'rust': ['rustfmt']}
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - junegunn/fzf.vim                                                         │
" │ https://github.com/junegunn/fzf.vim                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if executable('rg')
    let s:rg_cmd = "rg --hidden --follow"
    let s:rg_ignore = split(&wildignore, ',') + [
        \ 'node_modules', 'target', 'build', 'dist', '.stack-work'
        \ ]
    let s:rg_cmd .= " --glob '!{'" . shellescape(join(s:rg_ignore, ',')) . "'}'"
    let &grepprg=s:rg_cmd . ' --vimgrep'
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

nnoremap <silent> qE :Files %:p:h<CR>
nnoremap <silent> qe :Files<CR>
nnoremap <silent> qt :BTags<CR>
nnoremap <silent> qf :Find<CR>
command! -bang -complete=dir -nargs=* Dir call fzf#run(fzf#wrap('fd', {'source': 'fd --full-path -a -t d', 'dir': <q-args>}, <bang>0))

" This is the default extra key bindings
let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors
    \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

" Insert mode completion
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-l> <Plug>(fzf-complete-line)
nnoremap <C-e> :Dir<CR>
nnoremap <C-S-e> :Dir <C-r>=expand('%:p:h')<CR>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> setlocal laststatus=2 showmode
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - pbogut/fzf-mru.vim                                                       │
" │ https://github.com/pbogut/fzf-mru.vim                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <leader>. :FZFMru --prompt "❯> "<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:LustyJugglerDefaultMappings = 0
let LustyExplorerDefaultMappings = 0
let g:LustyExplorerAlwaysShowDotFiles = 1
nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-dispatch.git                                                   │
" │ https://github.com/tpope/vim-dispatch.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap MK :Make -j9
nmap MC :Make clean<cr>
nmap [QLeader]cc :Make -j10<cr>
nmap [QLeader]mc :Make distclean<cr>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - frazrepo/vim-rainbow                                                     │
" │ https://github.com/frazrepo/vim-rainbow                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf_defaults = {
\	'ctermfgs': ['lightblue'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'contains_prefix': 'TOP',
\	'parentheses_options': '',
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained',
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\		},
\		'ocaml': {
\			'parentheses': ['start=/(\ze[^*]/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\[|/ end=/|\]/ fold', 'start=/{/ end=/}/ fold'],
\		},
\		'tex': {
\			'parentheses_options': 'containedin=texDocZone',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody,vimExecute',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
\		},
\		'xml': {
\			'syn_name_prefix': 'xmlRainbow',
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'xhtml': {
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow',
\		},
\		'php': {
\			'syn_name_prefix': 'phpBlockRainbow',
\			'contains_prefix': '',
\			'parentheses': ['start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold contains_prefix=TOP'],
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\		},
\		'css': 0,
\		'sh': 0,
\	}
\ }
let s:rainbow_darkblue_colors = ["#2A4769", "#264263", "#223E5E"]
let s:rainbow_royalblue_colors = ['#4169E1', '#3D63D4', '#3B5FCC', '#385AC2', '#3454B5']
let g:rainbow_conf_defaults['guifgs'] = s:rainbow_royalblue_colors
let g:rainbow_conf = g:rainbow_conf_defaults
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - mhinz/vim-grepper                                                        │
" │ https://github.com/mhinz/vim-grepper                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <M-/> :Grepper -tool rg<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - FooSoft/vim-argwrap                                                      │
" │ https://github.com/FooSoft/vim-argwrap                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
nnoremap <silent> <leader>a :ArgWrap<CR>
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - jiangmiao/auto-pairs                                                     │
" │ https://github.com/jiangmiao/auto-pairs                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:AutoPairs =  {'(':')', '[':']', '{':'}', '<':'>'}
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - airblade/vim-rooter                                                      │
" │ https://github.com/airblade/vim-rooter                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:rooter_targets = '/,*' " directories and all files (default)
let g:rooter_cd_cmd="lcd" " change directory for the current window only
" change dir to current if there is no project
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - easymotion/vim-easymotion                                                │
" │ https://github.com/easymotion/vim-easymotion                                      │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap <Space> <Plug>(easymotion-f)
nmap F <Plug>(easymotion-overwin-f2)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - junegunn/vim-easy-align                                                  │
" │ https://github.com/junegunn/vim-easy-align                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - vimwiki/vimwiki                                                          │
" │ https://github.com/vimwiki/vimwiki                                                │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:vimwiki_ext2syntax = {'.md': 'markdown',
    \ '.mkd': 'markdown',
    \ '.wiki': 'media'}
let g:vimwiki_list = [{'path': '~/1st_level/'}]
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - liuchengxu/vista.vim                                                     │
" │ https://github.com/liuchengxu/vista.vim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:vista_sidebar_width = 20
let g:vista_disable_statusline = 1
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista_icon_indent = ["▸ ", ""]
let g:vista#renderer#icons = {
    \   "function": "ﬦ",
    \   "module": " ",
    \   "variable": "\ufb18 ",
    \   "constant": ""
    \  }
let g:vista_default_executive = 'coc'
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - rhysd/git-messenger.vim                                                  │
" │ https://github.com/liuchengxu/vista.vim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
nmap <C-f> <Plug>(git-messenger)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - haya14busa/vim-asterisk                                                  │
" │ https://github.com/haya14busa/vim-asterisk                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - lambdalisue/suda.vim                                                     │
" │ https://github.com/lambdalisue/suda.vim                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:suda_smart_edit = 1