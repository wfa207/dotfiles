" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

" -----------------------------------------------------------
" Features {{{
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Mapleader mapping -- determines what the leader is (until it is redefined)
" Note that we can effectively have 'cascading' leader mappings - i.e. certain
" sections of our mappings can use one leader, then we redefine the mapleader
" for subsequent sections

" clear all mappings before assignment
mapclear

let mapleader=","

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype on

" When splitting windows, I prefer to have the new window towards the right /
" bottom (depending on how I choose to split) of the active window
set splitright
set splitbelow

" By default, vim stores swap files in the current working directory.
" This is problematic when you have libraries that watch file changes (i.e.
" webpack). The following line saves these files to a central directory
" instead.
set dir=$HOME/.vim/tmp/swap
if !isdirectory(&dir)
	call mkdir(&dir, 'p', 0700)
endif

""}}}
" -----------------------------------------------------------
" Helper Functions {{{

function! SetTabsAndText(textwidthnum, tabwidthnum)
	let &l:textwidth = a:textwidthnum-1
	let &l:colorcolumn = a:textwidthnum
	let &l:tabstop = a:tabwidthnum
	let &l:softtabstop = a:tabwidthnum
	let &l:shiftwidth = a:tabwidthnum
	setlocal autoindent
	setlocal expandtab
endfunction

function! GetCurrentRelativeFilepath()
    return expand('%:F')
endfunction

function! CopyPythonFilepathToClipboard()
    let s:_filepath = GetCurrentRelativeFilepath()
    let s:_filepath = split(s:_filepath, '/')
    let s:_filepath[-1] = substitute(s:_filepath[-1], '\c\.py', '', '')
    let s:_filepath = join(s:_filepath, '.')
    call setreg('*', s:_filepath)
endfunction

""}}}
" -----------------------------------------------------------
" Vim-Plug {{{

" URL: https://github.com/junegunn/vim-plug
" Author: Junegunn Choi (https://github.com/junegunn)
" Description: A plugin manager for vim that ensures all plugins and runtime
" 			   files have their own private directories

call plug#begin('~/.vim/plugged')

" ==========================
" Plugins on GitHub
" ==========================
" NERDTree: Explore file system visually as a tree
Plug 'scrooloose/nerdtree'

" NERDCommenter: Allows for easy commenting in Vim
Plug 'scrooloose/nerdcommenter'

" Vim_Multiple_Cursors: Enables Sublime Text-like multiple selection feature
Plug 'terryma/vim-multiple-cursors'

" IndentPython: Corrects for Vim's native autoindent feature
Plug 'vim-scripts/indentpython.vim'

" YouCompleteMe: Python autocomplete feature built on top of jedi
Plug 'Valloric/YouCompleteMe'

" Ale: An asynchronous syntax checker
Plug 'w0rp/ale'

" ListToggle: Toggle Vim's loclist / quickfix windows
Plug 'Valloric/ListToggle'

" Fzf: Full-path fuzzy file, buffer, mru, tab... finder for Vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

" Async Run: Run scripts asynchronously in Vim
Plug 'skywind3000/asyncrun.vim'

" Supertab: Supertab is a vim plugin which allows you to use <Tab> for all
" your insert completion needs
" Plug 'ervandew/supertab'

" UltiSnips: Allows usage of snippets in Vim
Plug 'SirVer/ultisnips'

" Vim_Snippets: Collection of snippets (used with UltiSnips)
Plug 'honza/vim-snippets'

" Vim_Tmux_Navigator: Navigate between Vim & Tmux seamlessly
Plug 'christoomey/vim-tmux-navigator'

" Airline: A more informative status bar (current venv, git branch, etc.)
Plug 'vim-airline/vim-airline'

" VimFugitive: Integration between git and ViIntegration between git and VimPlugin
Plug 'tpope/vim-fugitive'

" Airline Themes: Themes for the Airline plugin
Plug 'vim-airline/vim-airline-themes'

" Snow Theme: Theme developed by nightsense
Plug 'nightsense/snow'

" SimpylFold: Help with indentation-based code folding
Plug 'tmhedberg/SimpylFold'

" FastFold: Speed up Vim's default folding mechanism
Plug 'Konfekt/FastFold'

" Vim Flake8: Flake 8
Plug 'nvie/vim-flake8'

" Javascript Vim: Syntax highlighting for JS
Plug 'pangloss/vim-javascript'

" Vim JSX: JSX syntax highlighting
Plug 'mxw/vim-jsx'

" Emmet VIM: JSX Snippet generation
Plug 'mattn/emmet-vim'

" Typescript VIM: Typescript syntax support
Plug 'leafgarland/typescript-vim'

" Vim JSX Typescript: Typescript & JSX syntax support
Plug 'peitalin/vim-jsx-typescript'

" Editorconfig: Define local rules that your editor can acknowledge
Plug 'editorconfig/editorconfig-vim'

" SCSS Syntax: Syntax highlighting for SCSS files
Plug 'cakebaker/scss-syntax.vim'

" Vimux: Interact with Tmux from Vim
Plug 'benmills/vimux'

" Vim_Surround: Interact with Tmux from Vim
Plug 'tpope/vim-surround'

" J_Daddy: Format json in Vim
Plug 'tpope/vim-jdaddy'

" Vim_Test: Run tests more conveniently using Tmux & Vim
Plug 'janko-m/vim-test'

" Pythonsense: Smarter movement commands tailored for Python
Plug 'jeetsukumaran/vim-pythonsense'

" VimWiki: Personal wiki pages written in Vim
Plug 'vimwiki/vimwiki'

" All plugins must be added before the following line
call plug#end()   					" Required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" Install plugins via Vim-Plug
noremap <Leader>vi :PlugInstall<CR>

" Update plugins via Vim-Plug
noremap <Leader>vu :PlugUpdate<CR>

" Clean plugins via Vim-Plug
noremap <Leader>vc :PlugClean<CR>
""}}}
" -----------------------------------------------------------
" Python {{{

" Python script to install activate_this.py script if it doesn't already exist
py3 << endpy3
import os

venv_dir_path = os.environ.get("VIRTUAL_ENV")

if venv_dir_path:
    activate_script_path = f"{venv_dir_path}/bin/activate_this.py"
    if not os.path.isfile(activate_script_path):
        print("Writing \"activate_this.py\" script.")
        os.system((\
        "echo "
        "\"$(curl -s https://raw.githubusercontent.com/pypa/virtualenv/master/virtualenv_embedded/activate_this.py)\" "
        ">> \"${VIRTUAL_ENV}/bin/activate_this.py\""
        ))
        print("Finished")
endpy3

""}}}
" -----------------------------------------------------------
" Display {{{

" Colorscheme
colorscheme snow
set background=dark

" Enable syntax highlighting
syntax on

" Turn on true colors in terminal
set termguicolors

set t_Co=256

" Suggested additional configuration variables to set in Snow Theme
" Doesn't seem to have an effect at the moment; see :h xterm-true-color
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Default text formatting / line-breaks
set colorcolumn=120
set encoding=utf-8
set shiftwidth=4
set textwidth=0
set wrapmargin=0
set tabstop=4
set softtabstop=4
set autoindent

" Highlight line that the cursor is currently on
set cursorline

" Flag excess whitespace
highlight ExtraWhitespace ctermbg=190 guibg=#dfff00
match ExtraWhitespace /\s\+$/

" =============================
" Airline Configuration
" =============================

" Enable Powerline fonts for more aesthetic appearance
let g:airline_powerline_fonts=1

" Smarter tab line allows for display of buffers
let g:airline#extensions#tabline#enabled=1

" Allow space after tabs but no in between them
let g:airline#extensions#whitespace#mixed_indent_algo=1

" Airline theme
let g:airline_theme='snow_dark'

" Enable better syntax highlighting for Python
let python_highlight_all=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.dirty='✎'

""}}}
" -----------------------------------------------------------
" NERDTree {{{

" URL: https://github.com/scrooloose/nerdtree
" Author: Martin Grenfell (https://github.com/scrooloose)
" Description: NERDTree provides a way for us to explore the file system
" 			   visually and open files and directories accordingly.

augroup nerdtree_setup
	autocmd!

	" Start NERDTree automatically when vim starts up with no files specified
	" autocmd StdinReadPre * let s:std_in=1
	" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") |
	"             \ NERDTree |
	"             \ endif

	" Start NERDTree automatically when vim starts up on a directory
	autocmd StdinReadPre * let s:std_in=1

	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
				\ exe 'NERDTree' argv()[0] |
				\ wincmd p |
				\ ene |
				\ endif

	" If NERDTree is the only window left, vim will automatically close
	autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
				\ q |
				\ endif
augroup END

" Have NERDTree show hidden files by default
let NERDTreeShowHidden=1
"
" Toggle NERDTree menu
noremap <Leader>b :NERDTreeToggle<CR>
noremap <Leader>n :NERDTree<CR>

" NERDTree split mappings are a bit counterintuitive (I decided to change them
" to v and s for vertical and horizontal split, respectively)
let g:NERDTreeMapOpenSplit='h'
let g:NERDTreeMapOpenVSplit='v'

" Unmap Jump to Sibling to prevent overriding of bindings above
let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''

" Hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
""}}}
" -----------------------------------------------------------
" NERDCommenter {{{

" URL: https://github.com/scrooloose/nerdcommenter
" Author: Martin Grenfell (https://github.com/scrooloose)
" Description: NERDCommenter provides automatic commenting capabilities in Vim

filetype plugin on

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Toggle comment
noremap <Leader><space> :call NERDComment(0, "toggle")<CR>
""}}}
" -----------------------------------------------------------
" Emmet {{{

" URL: https://github.com/mattn/emmet-vim
" Author: mattn (https://github.com/mattn)
" Description: Emmet integration with Vim

let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
\}"
""}}}
" -----------------------------------------------------------
" Ale {{{

" URL: https://github.com/w0rp/ale
" Author: w0rp (https://github.com/w0rp)
" Description: Syntax checker plugin

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1
" let g:ale_linters_explicit = 0
let g:ale_set_balloons = 1

" Python linters previously included 'pyls'
" I've dropped 'pyls' in favor of YCM (which relies on Jedi)
let g:ale_linters = {
			\ 'python': ['pylint'],
			\ 'javascript': ['eslint', 'flow'],
			\ 'typescript': ['tsserver', 'tslint']
			\}

let g:ale_fixers = {
            \ 'javascript': ['prettier'],
            \ 'typescript': ['prettier'],
            \ 'css': ['prettier'],
            \ 'python': ['black'],
            \}

" Error display options
let g:ale_echo_msg_format = '[%linter%]% (code)%: %s [%severity%]'
let g:ale_loclist_msg_format = '[%severity%][%linter%]% (code)%: %s'
let g:ale_sign_error = '✖' " Less aggressive than the default '>>'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_warning = '●'

" Linter settings
let g:ale_python_pylint_use_global = 1
" Script to run pylint with active virtual env
let g:ale_python_pylint_options = '--max-line-length=120 '
            \ . '--load-plugins pylint_django '
            \ . '--init-hook "exec(\"\"\"'
            \
            \ . 'import os\n'
            \ . 'import sys\n'
            \ . 'if os.environ.get(\"VIRTUAL_ENV\"):\n'
            \ . '   PY_V = sys.version[0]\n'
            \ . '   _f = os.path.join('
            \ .         '\"$VIRTUAL_ENV\", '
            \ .         '\"bin/activate_this.py\"'
            \ .    ')\n'
            \ . '   read_cmd = open(_f).read() if PY_V == \"3\" else open(_f)\n'
            \ . '   exec(read_cmd, dict(__file__=_f))'
            \ . '\"\"\")"'
"exec(\"\"\"import os\nimport sys\nif os.environ.get(\"VIRTUAL_ENV\"):\n  PY_V = sys.version[0]\n  _f = os.path.join(\"$VIRTUAL_ENV\", \"bin/activate_this.py\")\n  read_cmd = open(_f).read() if PY_V == \"3\" else open(_f)\n  exec(read_cmd, dict(__file__=_f))\"\"\")"
let g:ale_javascript_prettier_options = '--print-width 120 '
            \ . '--trailing-comma es5 '
            \ . '--single-quote '
            \ . '--parser flow '

" Mapping for GoTo Definition
" noremap <Leader>gd  :ALEGoToDefinition<CR>
" noremap <Leader>fr  :ALEFindReferences<CR>

" Error navigation Mapping
nnoremap <Leader>an :ALENextWrap<CR>
nnoremap <Leader>ap :ALEPreviousWrap<CR>
nnoremap <Leader>ad :ALEDetail<CR>

highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear ALEInfoSign

highlight ALEErrorSign ctermbg=NONE ctermfg=131 guibg=NONE guifg=#ae5865
highlight ALEWarningSign ctermbg=NONE ctermfg=179 guibg=NONE guifg=#e5bb7e
highlight ALEInfoSign ctermbg=NONE ctermfg=32 guibg=NONE guifg=#2b7ab2

" By default, VIM and python-language-server (pyls) are not aware of the
" virtualenv; the following code detects if a virtualenv is running and
" switches to the active virtualenv with the correct system path so
" python-language-server finds the right site packages. There is a bash
" function I've written that aims to achieve the same thing in a much simpler
" fashion, but Vim does not support loading .bashrc by default, since it runs
" bash commands with the '-ci' options enabled.

" let s:python_v = system("python --version")[7]

" if s:python_v == "3"
" py3 << endpy3
" import os
" import sys
" import subprocess

" venv_base_dir = os.environ.get('VIRTUAL_ENV')
" if venv_base_dir:
"     _filepath = os.path.join(venv_base_dir, 'bin/activate_this.py')
"     if os.path.isfile(_filepath):
"         # subprocess.call(f". {_filepath}", shell=True)
"         exec(open(_filepath).read(), dict(__file__=_filepath))
"         # os.system(f". {_filepath}")
"     else:
"         print("Virtual environment missing \"activate_this.py\" file")

" endpy3
" elseif s:python_v == "2"
" python << endpy2
" import os
" import sys
" import subprocess

" venv_base_dir = os.environ.get('VIRTUAL_ENV')
" if venv_base_dir:
"     _filepath = os.path.join(venv_base_dir, 'bin/activate_this.py')
"     if os.path.isfile(_filepath):
"         # subprocess.call(". {}".format(_filepath), shell=True)
"         execfile(open(_filepath), dict(__file__=_filepath))
"         # os.system(". {}".format(_filepath))
"     else:
"         print "Virtual environment missing \"activate_this.py\" file"

" endpy2
" endif

""}}}
" -----------------------------------------------------------
" List Toggle {{{

" URL: https://github.com/Valloric/ListToggle
" Author: Val Markovic (https://github.com/Valloric/)
" Description: Toggle Vim's loclist / quickfix windows

let g:lt_location_list_toggle_map = '<Leader>al'
" let g:lt_quickfix_list_toggle_map = '<leader>q'

""}}}
" -----------------------------------------------------------
" Fzf {{{

" URL: https://github.com/junegunn/fzf.vim
" Author: Junegunn Choi (https://github.com/junegunn)
" Description: Full path fuzzy file, buffer, mru, tag, ... finder for Vim


" Custom mapping for horizontal split
let g:fzf_action = {
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit',
  \}

" Reserve bottom 20% of screen for fzf output
let g:fzf_layout = { 'down': '~20%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
   \ 'bg':      ['bg', 'Normal'],
   \ 'hl':      ['fg', 'Comment'],
   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
   \ 'hl+':     ['fg', 'Statement'],
   \ 'info':    ['fg', 'PreProc'],
   \ 'border':  ['fg', 'Ignore'],
   \ 'prompt':  ['fg', 'Conditional'],
   \ 'pointer': ['fg', 'Exception'],
   \ 'marker':  ['fg', 'Keyword'],
   \ 'spinner': ['fg', 'Label'],
   \ 'header':  ['fg', 'Comment'] }

" Search for files by name
nnoremap <C-p> :Files<CR>

" Use Silver Searcher to search file content
" Space here is intentional
nnoremap <Leader>fa :Ag<CR>

" Search within a Buffer
nnoremap <Leader>ff :SearchFile<CR>

" Search Help Tags
nnoremap <Leader>h :Helptags<CR>


" Use Ale to search for references to symbol under cursor
" nnoremap <Leader>fr :FZFFindRefs

" Control how preview window displays syntax
let $BAT_THEME = 'TwoDark'

" Ag customization
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \				    '--ignore .git --hidden',
  \                 fzf#vim#with_preview({
  \                                       'options': [
  \                                                     '--prompt', 'All> ',
  \                                                     '--delimiter', ':',
  \                                                     '--nth',  '4..',
  \                                                  ],
  \                                      }, 'right:50%'), <bang>0)


" Ctrl-P customization
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
  \												       'source': 'ag --ignore .git --hidden -g .'
  \												      }, 'right:50%'), <bang>0)

"""}}}
" -----------------------------------------------------------
" YouCompleteMe {{{

" URL: https://github.com/Valloric/YouCompleteMe
" Author: Val Markovic (https://github.com/Valloric)
" Description: Fuzzy-search code completion engine for Vim. Python
" 			   functionality is built-in; other languages are available but
" 			   require plugins

" Ensure autocomplete window disappears once it is no longer in use
let g:ycm_autoclose_preview_window_after_completion=1

" Turn off diagnostics reporting
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0

" Select next completion
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']

" Select previous completion
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" These are in autocommands now (only used for Python)
" Go to definition / declaration of a variable or class
nnoremap <Leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Go to definition / declaration of a variable or class
nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>

""}}}
" -----------------------------------------------------------
" SuperTab {{{

" URL: https://github.com/ervandew/supertab
" Author: Eric Van Dewoestine (https://github.com/ervandew)
" Description: Supertab is a vim plugin which allows you to use <Tab> for all
"			   your insert completion needs; mainly using this to get YCM
"              to play nice with UltiSnips

" Supertab's default completion selection should be YouCompleteMe's
let g:SuperTabDefaultCompletionType = '<C-n>'
""}}}
" -----------------------------------------------------------
" UltiSnips {{{

" URL: https://github.com/SirVer/ultisnips
" Author: Holger Rapp (https://github.com/SirVer)
" Description: UltiSnips provides snippets in Vim

" Add custom snippets
let g:UltiSnipsSnippetDirectories=[
            \ "UltiSnips",
            \ $HOME."/.vim/my_snippets",
            \ ]

" The below helps UltiSnips play nice with YCM
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
""}}}
" -----------------------------------------------------------
" Vim Fugitive {{{

" URL: https://github.com/tpope/vim-fugitive
" Author: Tim Pope (https://github.com/tpope)
" Description: A Git wrapper for Vim

" Bring up the Git Status page to interactively add / edit / commit changes
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gv :Gvdiff<CR>
""}}}
" -----------------------------------------------------------
" SimpylFold {{{

" URL: https://github.com/tmhedberg/SimpylFold
" Author: Taylor M. Hedberg (https://github.com/tmhedberg)
" Description: Intuitive folding for Python files

let g:SimpylFold_docstring_preview = 0
""}}}
" -----------------------------------------------------------
" Vim Multiple Cursor {{{

let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
""}}}
" -----------------------------------------------------------
" Vimux {{{

" Vimux's default 'VimuxZoomRunner' doesn't work properly
" The fix below should zoom even from another zoomed pane
function! VimuxZoomRunner()
	if exists("g:VimuxRunnerIndex")
		call _VimuxTmux("select-"._VimuxRunnerType()." -t ".g:VimuxRunnerIndex)
		call _VimuxTmux("resize-pane -Z -t ".g:VimuxRunnerIndex)
	endif
endfunc

" Prompt for a command to run
noremap <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
noremap <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
noremap <Leader>vr :VimuxInspectRunner<CR>

" Zoom the tmux runner pane
noremap <Leader>vz :call VimuxZoomRunner()<CR>
""}}}
" -----------------------------------------------------------
" Vim-Test {{{

let test#strategy = "vimux"
let test#python#runner = "pytest"

nnoremap <silent> <Leader>tt :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ta :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>tg :TestVisit<CR>

""}}}
" -----------------------------------------------------------
" Vim-Javascript {{{

let g:javascript_plugin_flow = 1

""}}}
" -----------------------------------------------------------
" Must-Have Options"{{{

" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.

" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" Note that the confirm option is also listed below in the "Useability
" options" section
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Search as you type
set incsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" Foldmethod controls how lines are folded in vim. Currently, we are setting
" the foldmethod to marker, which gives us a way of sharing our code folds
" with others
set foldmethod=marker
" set foldlevel=99
""}}}
" -----------------------------------------------------------
" Usability Options {{{

" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number
set relativenumber

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout timeoutlen=1000 ttimeoutlen=200

" Have Vim share its clipboard with the system clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
""}}}
" -----------------------------------------------------------
" Autocommands {{{

" Autocommand groups help namespace autocommands and ensure we
" only execute autocommands once (otherwise they will compound
" each time we source our vimrc)

" `autocmd!` clears the autocmd associated with the augroup, if it exists
augroup webdev_setup
	autocmd!
	" Indentation options & bindings for js, html, and css files
	autocmd BufNewFile,BufRead *.tsx,*.ts,*.jsx,*.js,*.html,*.css
				\ call SetTabsAndText(120, 4) |
augroup END


augroup python_setup
	autocmd!
	" Indentation options & bindings for python files
	autocmd BufNewFile,BufRead *.py,*.pyc
				\ call SetTabsAndText(120, 4) |
				\ setlocal autoindent |
				\ setlocal fileformat=unix |
                " Defer to SimpylFold
				\ setlocal foldmethod=expr |
augroup END

augroup rst_setup
	autocmd!
	" Indentation options for reStructuredText files
	" Setting a manual foldmethod for now; can set this to
	" an expression (see: `fold-expr`) but don't know how to
	" do so at the moment
	autocmd BufNewFile,BufRead *.rst
				\ call SetTabsAndText(80, 4) |
				\ setlocal autoindent |
				\ setlocal foldmethod=manual |
				\ setlocal fileformat=unix |
augroup END

augroup markdown_setup
	" By default, Vim detects *.md files as Modula-2 files; this line forces all
	" *.md files to be read as markdown
	autocmd BufNewFile,BufRead *.md
				\ setlocal filetype=markdown |
				\ call SetTabsAndText(80, 4)
augroup END

augroup vimscript_setup
	autocmd FileType vim
				\ call SetTabsAndText(80, 4) |
				\ setlocal autoindent
augroup END

""}}}
" -----------------------------------------------------------
" Mappings {{{

" =============================
" Quick Access Files
" =============================
"
" Open .vimrc file
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :so $MYVIMRC<CR>

" Open .bashrc file
nnoremap <Leader>eb :vsplit ~/.bashrc<CR>
nnoremap <Leader>sb :!. ~/.bashrc<CR>

" Keep a small notebook of ongoing thoughts to be transferred to other mediums
" for more permanent storage
nnoremap <Leader>et :vsplit ~/.thoughts.md<CR>

" Keep a scratch pad for python scripts
nnoremap <Leader>ep :vsplit ~/.scratch.py<CR>

" =============================
" Useful mappings
" =============================

" Map <C-C> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <silent> <C-C> :nohl<CR><C-L><C-C>

" Close a window (similar to most other tabbed programs, but press ctrl+W
" twice)
nnoremap <C-W><C-W> :q<CR>

" Open a new tab
nnoremap <C-T> :tabnew<CR>

" Toggle line numbers
nnoremap <C-q> :set invnumber!<CR>

" Ensure Enter inserts new line
inoremap <CR> <CR>

" Toggle line numbers between absolute and relative
nnoremap <C-a> :set relativenumber!<CR>

" Easier navigation between panes
" Navigate right
nnoremap <C-l> <C-w>l

" Navigate left
nnoremap <C-h> <C-w>h

" Navigate up
nnoremap <C-k> <C-w>k

" Navigate down
nnoremap <C-j> <C-w>j

" Macro shortcut
nnoremap <Space> @q

" Insert 'very magic' option into search
noremap / /\v
noremap ? ?\v

" Copy filename to clipboard register (*)
nnoremap <Leader>fp :call CopyPythonFilepathToClipboard()<CR>

" Reload all buffers
nnoremap <Leader>ea :bufdo e<CR>

""}}}
" -----------------------------------------------------------
" Abbreviations {{{
iabbrev @@ wes@test.com
""}}}
" -----------------------------------------------------------
