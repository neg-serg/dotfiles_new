local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command
vim.o.termguicolors = true
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Generic                                                                      │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate',
          config = function() require'plugcfg/treesitter' end
    } -- better highlight
    use {'airblade/vim-rooter',
         config = function() require'plugcfg/vim-rooter' end
    } -- autochdir for project root or for current dir
    use {'FooSoft/vim-argwrap',
        cmd = {'ArgWrap'},
        opt=false,
        config = function() require'plugcfg/argwrap' end
    } -- vim arg wrapper
    use {'jamessan/vim-gnupg', ft = {'gpg'}, opt=true} -- transparent work with gpg-encrypted files
    use {'nacro90/numb.nvim', config = [[require('numb').setup()]] }
    use {'kopischke/vim-fetch'} -- vim path/to/file.ext:12:3
    use {'neg-serg/lusty',
          config = function()
            vim.g.LustyJugglerDefaultMappings = 0
            vim.g.LustyExplorerDefaultMappings = 0
            vim.g.LustyExplorerAlwaysShowDotFiles = 1
          end,
          cmd = {'LustyFilesystemExplorerFromHere'},
          opt = true,
    } -- file/buffer explorer
    use {'norcalli/nvim-colorizer.lua'} -- high-performance color highlighter for Neovim
    use {'ntpeters/vim-better-whitespace'} -- delete whitespaces with ease
    use {'ojroques/nvim-bufdel'} -- better buffer delete
    use {'pbrisbin/vim-mkdir'} -- auto make dir without asking
    use {'reedes/vim-pencil',
          opt=true,
          cmd = {'Pencil', 'PencilHard', 'PencilSoft', 'PencilToggle'},
          ft = {'txt', 'markdown', 'rst'}
    } -- better text support
    use {'reedes/vim-wordy', opt=false} -- style check for english
    use {'romgrk/winteract.vim',
          cmd = {'InteractiveWindow'},
          config = function() require'plugcfg/wininteract' end,
          opt=false
    } -- interactive window resize
    use {'simnalamburt/vim-mundo', cmd = {'MundoToggle'}, opt=true} -- undo tree
    use {'thinca/vim-ref'} -- integrated reference viewer for help with separated window
    use {'vimwiki/vimwiki'} -- personal wiki for vim
    use {'p00f/nvim-ts-rainbow'} -- treesitter-based rainbow
    use {'antoinemadec/FixCursorHold.nvim'} -- fix cursorhold slowdown
    use {'MTDL9/vim-log-highlighting'} -- better log highlighter
    use {'justinmk/vim-gtfo'} -- open filemanager or terminal in current dir
    use {'akinsho/nvim-bufferline.lua'} -- fancy bufferline
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Neovim lua stuff                                                             │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'tjdevries/nlua.nvim'} -- neovim lua autocompletion
    use {'norcalli/nvim_utils'} -- new neovim extensions
    use {'svermeulen/vimpeccable'} -- neovim lua extensions
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Dev                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'antoinemadec/coc-fzf'} -- coc fzf support
    use {'b3nj5m1n/kommentary'} -- alternative commenter
    use {'dense-analysis/ale',
        config = function() require'plugcfg/ale' end
    } -- async linter with lsp support
    use {'ElPiloto/sidekick.nvim'} -- experimental outline window
    use {'eraserhd/parinfer-rust', run = 'cargo build --release'} -- support lisps
    use {'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require'plugcfg/gitsigns' end
    } -- async gitsigns
    use {'lewis6991/spellsitter.nvim'} -- treesitter-based spellsitter
    use {'mattn/vim-sonictemplate', cmd = 'Template'} -- snippets alternative
    use {'metakirby5/codi.vim', cmd = {'Codi', 'CodiUpdate'}, opt = true} -- nice scratchpad for hackers
    use {'mfussenegger/nvim-dap', opt = true,
        config = function() require'plugcfg/dap' end
    } -- neovim debugger protocol support
    use {'neoclide/coc.nvim', config = function() require'plugcfg/coc' end } -- lsp autocomplete
    use {'plasticboy/vim-markdown', opt = true} -- markdown vim mode
    use {'theHamsta/nvim-dap-virtual-text', opt = true} -- virtual debugging text support
    use {'tpope/vim-apathy'} -- better include jump
    use {'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'},
        config = function() require'plugcfg/vim-dispatch' end
    } -- provide async build
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Edit                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'AndrewRadev/splitjoin.vim'} -- one-line <-> multiline converter
    use {'junegunn/vim-easy-align', config = function() require'plugcfg/easyalign' end } -- use easy-align, instead of tabular
    use {'machakann/vim-sandwich'} -- support sandwich surrounds
    use {'svermeulen/vim-NotableFt'} -- better ft
    use {'andymass/vim-matchup',
        event = 'VimEnter',
        config = function() require'plugcfg/vim-matchup' end
    } -- generic matcher
    use {'tommcdo/vim-exchange'} -- exchange operator
    use {'tpope/vim-repeat'} -- dot for surround
    use {'tpope/vim-surround'} -- new commands to vim for generic brackets
    use {'wellle/targets.vim'} -- better text objects
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Search                                                                       │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'brooth/far.vim'} -- better find and replace
    use {'eugen0329/vim-esearch', config = function() require'plugcfg/esearch' end } -- the best of the best way to search
    use {'haya14busa/vim-asterisk', config = function() require'plugcfg/vim-asterisk' end } -- smartcase star
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end } -- latest fzf binary
    use {'junegunn/fzf.vim', config = function() require'plugcfg/fzf' end } -- fzf vim bindings
    use {'pbogut/fzf-mru.vim', config = function() require'plugcfg/fzfmru' end } -- fzf mru source
    use {'yuki-ycino/fzf-preview.vim'} -- integration fzf preview with coc
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Appearance                                                                   │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {"aouelete/sway-vim-syntax"} -- add sway syntax
    use {'Bakudankun/PICO-8.vim'} -- pico-8 cartridge files
    use {'kyazdani42/nvim-web-devicons', config = function() require'plugcfg/nvim-web-devicons' end } -- fancy webicons
    use {'neg-serg/neg'} -- my colorscheme
    use {'RRethy/vim-hexokinase', run = "make hexokinase"} -- best color highlighting
    use {'sheerun/vim-polyglot'} -- language pack collection
    use {'tridactyl/vim-tridactyl'} -- tridactyl support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ Ops                                                                          │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'pearofducks/ansible-vim',
        opt = true,
        ft = 'ansible',
        config = function() require'plugcfg/ansible' end
    } -- ansible support
    use {'saltstack/salt-vim'} -- salt sls support
-- ┌───────────────────────────────────────────────────────────────────────────────────┐
-- │ █▓▒░ DCVS                                                                         │
-- └───────────────────────────────────────────────────────────────────────────────────┘
    use {'iberianpig/tig-explorer.vim'} -- tig integration
    use {'rhysd/conflict-marker.vim',
        config = function()
            vim.cmd[[highlight ConflictMarkerBegin guibg=#2f7366]]
            vim.cmd[[highlight ConflictMarkerOurs guibg=#2e5049]]
            vim.cmd[[highlight ConflictMarkerTheirs guibg=#344f69]]
            vim.cmd[[highlight ConflictMarkerEnd guibg=#2f628e]]
            vim.cmd[[highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81]]
        end
    } -- good conflict marker
    use {'sindrets/diffview.nvim',
        cmd = {'DiffviewLoad'},
        config = function() require'plugcfg/diffview' end
    } -- diff view for multiple files
    use {'tpope/vim-fugitive'} -- git stuff old
end, config = {
    display = {
        open_fn = require('packer.util').float, }
    }
})
