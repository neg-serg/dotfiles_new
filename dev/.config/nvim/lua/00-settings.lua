vim.opt.exrc = false
vim.opt.secure = true
vim.opt.termguicolors = true
vim.opt.path = '/home/neg/.config/nvim,/home/neg/.config/nvim/after,/home/neg/.local/share/nvim/site/'
vim.opt.formatprg = 'par -140'                               -- Better format
vim.opt.report = 0                                           -- No report on substitution
vim.opt.fileformats = 'unix,dos,mac'                         -- File format fallback
vim.opt.synmaxcol = 256                                      -- No syntax hi for too long lines
vim.opt.regexpengine = 0                                     -- Autoselect regex engine
vim.opt.conceallevel = 1                                     -- Enable conceal without hide
vim.opt.concealcursor = 'niv'                                -- Conceal cursor
vim.opt.keymap = 'russian-jcukenwin'                         -- Add ru keymap
vim.opt.magic = true                                         -- Use magic
vim.opt.listchars = {}                                       -- Disable listchars
vim.opt.path = vim.opt.path + ',.,..,/usr/include,./include,../include,*' -- Add path settings
vim.opt.hidden = true                                        -- It hides buffers instead of closing them
vim.opt.lazyredraw = true                                    -- Reduce useless redrawing
vim.opt.backup = true                                        -- Backuping is good
vim.opt.writebackup = true                                   -- Backuping is good for write
vim.opt.cindent = true                                       -- Smart indenting for c-like code
vim.opt.cinoptions = 'b1,g0,N-s,t0,(0,W4'                    -- See :h cinoptions-values
vim.opt.clipboard = 'unnamedplus'                            -- Always clipboard all operations
vim.opt.copyindent = true                                    -- Copy the previous indentation on autoindenting
vim.opt.diffopt:append {'internal','algorithm:patience'}     -- Better diff algorithm
vim.opt.eadirection = 'hor'                                  -- Ver/hor/both - where does equalalways apply
vim.opt.expandtab = true                                     -- Tabs are spaces = not tabs
vim.opt.fileencodings = 'utf-8,default'                      -- Less file encodings
vim.opt.gdefault = true                                      -- This makes search/replace global by default
vim.opt.ignorecase = true                                    -- Case insensitive search
vim.opt.iminsert = 0                                         -- Write latin1 characters first
vim.opt.imsearch = 0                                         -- Search with latin1 characters first
vim.opt.inccommand = 'nosplit'                               -- Better live substitution
vim.cmd('set isfname+={,}')                                  -- Scan in filenames in such brackets
vim.opt.jumpoptions = 'stack'                                -- Jumplist behave like tagstack
vim.opt.linespace = 0                                        -- No extra spaces between rows
vim.opt.matchtime = 0                                        -- Default time to hi brackets too long for me
vim.opt.matchpairs:append '<:>'                              -- More matchpairs
vim.opt.maxfuncdepth = 100                                   -- Maximum depth of function calls for user functions
vim.opt.maxmapdepth = 1000                                   -- Maximum number of times a mapping is done without resulting in a character to be used.
vim.opt.maxmempattern = 1000                                 -- Maximum amount of memory (in Kbyte to use for pattern matching.
vim.opt.autochdir = false                                    -- Dont change pwd automaticly because of problems with plugins
vim.opt.autoread = false                                     -- Autoread file on change
vim.opt.autowrite = false                                    -- Dont autowrite by default
vim.opt.foldenable = false                                   -- Disable folds as
vim.opt.joinspaces = false                                   -- Prevents inserting two spaces after punctuation on a join (J
vim.opt.showmatch = false                                    -- Show matching brackets/parenthesis
vim.opt.spell = false                                        -- Disable spell checking by default
vim.opt.number = true                                        -- Line numbers on
vim.opt.pumblend = 15                                        -- setup pmenu transparency
vim.opt.pumheight = 10                                       -- Do not make pmenu too wide
vim.opt.scrolljump = 0                                       -- Lines to scroll when cursor leaves screen
vim.opt.scrolloff  = 0                                       -- Minimum lines to keep above and below cursor
vim.opt.scrollback = 0                                       -- Disable scrollback
vim.opt.sidescrolloff = 0                                    -- Min num of scr columns to keep to the left and to the
vim.opt.shiftround = false                                   -- Makes indenting a multiple of shiftwidth
vim.opt.shiftwidth = 4                                       -- Spaces for autoindents
vim.opt.termguicolors = true                                 -- Enable termguicolors
vim.opt.confirm = false                                      -- Disable no write
vim.opt.incsearch = true                                     -- Move cursor during search
vim.opt.wildmenu = true                                      -- Command line completion mode
vim.opt.wildignorecase = true                                -- Ignore case for wildmenu
vim.opt.wildignore:append {
	"*.7z" , "*.aux" , "*.avi" , "*.bak"
	, "*.bib" , "*.class" , "*.cls" , "*.cmi"
	, "*.cmo" , "*.doc" , "*.docx" , "*.dvi"
	, "*.flac" , "*.flv" , "*.gif" , "*.ico"
	, "*.jpeg" , "*.jpg" , "*.log" , "*.min*.js"
	, "*.mov" , "*.mp3" , "*.mp4" , "*.mpg"
	, "*.nav" , "*.o" , "*.ods" , "*.odt"
	, "*.ogg" , "*.opus" , "*.out" , "*.pdf"
	, "*.pem" , "*.png" , "*.rar" , "*.sty"
	, "*.svg" , "*.swp" , "*.swp*." , "*.tar"
	, "*.tgz" , "*.toc" , "*.wav" , "*.webm"
	, "*.xcf" , "*.xls" , "*.xlsx" , "*.zip"
}
vim.opt.hlsearch = true                                      -- Highlight search results (enforce
vim.opt.shortmess:append 'aoOstTWAIcqFS'                     -- Shorting messages for all
vim.opt.showmode = true                                      -- Show the mode ("-- INSERT --" at the bottom
vim.opt.showtabline = 0                                      -- Do not show tab line
vim.opt.smartcase = true                                     -- Case sensitive when uc present
vim.opt.softtabstop = 4                                      -- Let backspace delete indent
vim.opt.splitbelow = true                                    -- Puts new split windows to the bottom of the current
vim.opt.splitright = true                                    -- Puts new vsplit windows to the right of the current
vim.opt.switchbuf = 'useopen,usetab'                         -- useopen may be useful for re-using QuickFix window.
vim.opt.tabstop = 4                                          -- An indentation every four columns
vim.opt.timeoutlen = 400                                     -- 400 ms wait to sequence complete
vim.opt.ttimeoutlen = 20                                     -- Very fast and also you shouldnt make combination too fast
vim.opt.updatetime = 250                                     -- Faster diagnostics
vim.opt.virtualedit = 'onemore,block'                        -- Allow for cursor beyond last character
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'                        -- Backspace and cursor keys wrap too
vim.opt.wildmode = 'full'                                    -- Command <Tab> completion = list matches = then longest common part = then all.
vim.opt.wildoptions = 'pum'                                  -- Wild options
vim.opt.winblend = 15                                        -- Pseudo-transparency for floating windows
vim.opt.winminheight = 0                                     -- Windows can be 0 line high
vim.opt.winminwidth = 0                                      -- Windows can be 0 line width
vim.opt.wrap = false                                         -- Do not wrap lines by default
vim.opt.mouse = 'a'                                          -- Add mouse support
vim.opt.signcolumn = 'number'                                -- Merge sign and numbers
vim.opt.backupdir = '/home/neg/trash/'                       -- Setup backupdir
vim.opt.directory = '/home/neg/trash/'                       -- Directory for swap files
vim.opt.undodir = '/home/neg/trash/'                         -- Setup undo dir
vim.opt.swapfile = false                                     -- No swap file
vim.opt.undofile = true                                      -- Enable undofile
vim.opt.undolevels = 1000                                    -- Maximum number of changes that can be undone
vim.opt.undoreload = 10000                                   -- Maximum number lines to save for undo on a buffer reload
vim.opt.shada = "!,'100,<50,s100,h,:100,%,/100"              -- Shada settings
vim.opt.background = 'dark'
-- -- formatoptions+=t -- Auto-wrap using textwidth (not comments)
-- -- formatoptions+=c -- Auto-wrap comments too
-- -- formatoptions+=r -- Continue the comment header automatically on <CR>
-- -- formatoptions+=q -- Allow formatting of comments with gq
-- -- formatoptions+=n -- Recognize numbered lists when autoindenting
-- -- formatoptions+=l -- Don't break long lines in insert mode
-- -- formatoptions+=1 -- Don't break lines after one-letter words, if possible
-- -- formatoptions-=o -- Don't insert comment leader with 'o' or 'O'
-- -- formatoptions-=2 -- Don't use second line of paragraph when autoindenting
-- -- formatoptions-=v -- Don't worry about vi compatiblity
-- -- formatoptions-=b -- Don't worry about vi compatiblity
-- -- formatoptions-=j -- Delete comment character when joining
vim.opt.formatoptions = 'n1jcroql'
-- -- cpoptions+=$ -- No line redisplay -> put a '$' at the end
-- -- cpoptions+=A -- -- : write --
-- -- cpoptions+=B -- A backslash has no special meaning in mappings
-- -- cpoptions+=F -- :write opt('o', name for current buffer if no
-- -- cpoptions+=W -- Overwrite file when possible
-- -- cpoptions+=c -- Search -> end of any match at the cursor pos but not start of the next line
-- -- cpoptions+=d -- Make ./ in tags relative to tags file in current dir
-- -- cpoptions+=e -- :@r adds CR and nonlinewise
-- -- cpoptions+=s -- opt('o', buf opts before it created
-- -- cpoptions+=a -- :read with a filename opt('o', the alternate filename for window
vim.opt.cpoptions = '_$ABFWcdesa'
vim.cmd('syntax on')
